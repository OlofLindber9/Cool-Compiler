module Code where 
    
import Annotated ()
import CMM.Abs (Id(..), Type(..), CmpOp(..), MulOp(..), AddOp(..))
import FunType (FunType(..))

-- * Idealized JVM instructions

-- | JVM function names bundled with their type.
data Fun = Fun { funId :: Id, funFunType :: FunType }
    deriving Show

-- | Address of a local variable.
type Addr = Int

-- | Jump target.
newtype Label = L { theLabel :: Int }
    deriving (Eq, Enum, Show)

-- | Idealized JVM instructions
--   Some idealized instructions (e..g, @Inc Type_double@)
--   decompose into several real JVM instructions.

data Code
    = Store Type Addr
    | Load Type Addr 
    | IConst Integer
    | DConst Double
    | Dup Type
    | Pop Type
    | Return Type
    | Call Fun

    | Label Label
    | Goto Label
    | If CmpOp Label
    | IfCmp Type CmpOp Label


    | DCmp 


    | Inc Type Addr Int 
    | Mul Type MulOp
    | Add Type AddOp

    | I2D
    | Comment String
    | Raw String Int  -- ^ Raw JVM instruction with explicit stack delta.

    deriving (Show)

pattern IfZ l = If OEq l
pattern IfNZ l = If ONEq l 

negateCmp :: CmpOp -> CmpOp
negateCmp = \case
    OEq -> ONEq
    ONEq -> OEq 
    OLt -> OGtEq 
    OGt -> OLtEq
    OLtEq -> OGt
    OGtEq -> OLt

flipCmp :: CmpOp -> CmpOp 
flipCmp = \case
    OEq -> OEq
    ONEq -> ONEq
    OLt -> OGt
    OGt -> OLt
    OLtEq -> OGtEq
    OGtEq -> OLtEq

-- | Compute the number of machine words in something. 

class Size a where 
    size :: a -> Int

instance Size Type where
    size t = case t of 
        Type_int -> 1
        Type_double -> 2 
        Type_bool -> 1 
        Type_void -> 0

instance Size Id where 
    size _ = 0

instance (Size a, Size b) => Size (a,b) where
    size (x,y) = size x + size y

instance Size a => Size [a] where
    size = sum . map size 

instance Size FunType where 
    size (FunType t ts) = size ts - size t

instance Size Fun where
    size (Fun _ t ) = size t 

instance Size Code where
    size c = case c of
        Store t _       -> - (size t)
        Load t _        -> (size t) 
        IConst _        -> 1
        DConst _        -> 2
        Dup t           -> (size t)
        Pop t           -> - (size t)
        Return t        -> (size t)
        Call f          -> - (size f)
        Label _         -> 0
        Goto _          -> 0
        If _ _          -> -1
        IfCmp t _ _     -> (-2 * size t)
        DCmp            -> -2
        Inc t _ _       -> 0 
        Mul t _         -> -(size t)
        Add t _         -> -(size t)
        I2D             -> 1
        Comment _       -> 0
        Raw _ n         -> n

-- | Print something in Jasmin-syntax.

class ToJVM a where 
    toJVM :: a -> String 

instance ToJVM Type where
    toJVM t = case t of 
        Type_int -> "I"
        Type_void -> "V"
        Type_double -> "D"
        Type_bool -> "Z" 

instance ToJVM FunType where 
    toJVM (FunType t ts) = "(" ++ (toJVM =<< ts ) ++ ")" ++ toJVM t 

instance ToJVM Fun where 
    toJVM (Fun (Id f) t ) = f ++ toJVM t

instance ToJVM Label where
    toJVM (L l ) = "L" ++ show l

instance ToJVM MulOp where 
    toJVM op = case op of 
        OTimes -> "mul"
        ODiv -> "div" 

instance ToJVM AddOp where 
    toJVM op = case op of 
        OPlus -> "add"
        OMinus -> "sub" 

instance ToJVM CmpOp where 
    toJVM op = case op of 
        OLt -> "lt"
        OGt -> "gt"
        OLtEq -> "le"
        OGtEq -> "ge"
        OEq -> "eq" 
        ONEq -> "ne" 

-- | Printing 'Code' chooses the best bytecode representation for an idealized
--   instruction.

instance ToJVM Code where 
    toJVM = \case 
        Store t n -> prefix t ++ "store" ++ sep 3 n ++ show n
        Load t n -> prefix t ++ "load" ++ sep 3 n ++ show n 
        Return t -> prefix t ++ "return" 
        Call f -> "invokestatic " ++ toJVM f 
        DConst d -> "ldc2_w " ++ show d

        IConst i 
            | i == -1 -> "iconst_m1"
            | i >= 0 && i <= 5 -> "iconst_" ++ show i 
            | isByte i -> "bipush " ++ show i 
            | otherwise -> "ldc " ++ show i 

        Dup Type_double -> "dup2"
        Dup _ -> "dup" 
        Pop Type_double -> "pop2" 
        Pop _ -> "pop" 

        Label l -> toJVM l ++ ":" 
        Goto l -> "goto " ++ toJVM l
        If op l -> "if" ++ toJVM op ++ " " ++ toJVM l
        
        c@(IfCmp Type_double _ _ ) -> impossible c 
        c@(IfCmp Type_void _ _ ) -> impossible c 

        IfCmp _ op l -> "if_icmp" ++ toJVM op ++ " " ++ toJVM l 

        DCmp -> "dcmpg" -- Note: dcmpg and dcmpl only differ in the treatment of NaN

        Inc Type_int a k -> "iinc " ++ show a ++ " " ++ show k 

        Mul t op -> prefix t ++ toJVM op
        Add t op -> prefix t ++ toJVM op

        I2D -> "i2d"

        Comment c -> c
        Raw s _   -> s

prefix :: Type -> String
prefix t = case t of
    Type_int -> "i"
    Type_void -> ""
    Type_double -> "d"
    Type_bool -> "i"

sep :: Int -> Addr -> String
sep i a 
    | a <= i = "_"
    | otherwise = " " 

isByte :: Integer -> Bool
isByte i = i >= -128 && i <= 127

impossible :: Code -> String 
impossible c = error "undefined: " ++ show c
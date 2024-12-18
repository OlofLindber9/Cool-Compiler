-- Programming Language Technology (Chalmers DAT151 / GU DIT231)
-- (C) 2022-24 Andreas Abel
-- All rights reserved.

{-# OPTIONS_GHC -Wno-unused-imports #-} -- Turn off unused import warning off in stub

-- | Compiler for C--, producing symbolic JVM assembler.

module Compiler where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.RWS

import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map

import Annotated
import Code
import FunType (FunType(..), funType)

-- | Type signatures and JVM names of functions. 

type Sig = Map Id Fun

-- | Local variables. 

type Cxt      = [CxtBlock]
type CxtBlock = [(Id, Type)]

-- | State for compiling a function 
data St = St 
   { sig :: Sig
   , cxt :: Cxt
   , limitLocals :: Int
   , currentStack :: Int
   , limitStack :: Int
   , nextLabel :: Label
   , output :: Output
   }

initSt :: Sig -> St
initSt s = St
  { sig = s
  , cxt = [[]]
  , limitLocals = 0
  , currentStack = 0
  , limitStack = 0
  , nextLabel = L 0
  , output = []
  }

-- | Compiling a definition produces a traversed sequence of instructions. 

type Output = [Code]

-- | Compilation monad.

type Compile = State St

-- | Builtin-functions.

builtin :: [(Id, Fun)]
builtin = 
  [ (Id "printInt" , Fun (Id "Runtime/printInt" ) $ FunType Type_void [Type_int]),
    (Id "printDouble" , Fun (Id "Runtime/printDouble" ) $ FunType Type_void [Type_double]),
    (Id "readInt" , Fun (Id "Runtime/readInt" ) $ FunType Type_int []),
    (Id "readDouble" , Fun (Id "Runtime/readDouble" ) $ FunType Type_double [])
  ]

-- | Entry point.

compile
  :: String  -- ^ Class name.
  -> Program -- ^ Type-annotated program.
  -> String  -- ^ Generated jasmin source file content.
compile name (PDefs defs) = 
  unlines $ concat $ header : map (compileDef sig0) defs

  where
  -- Signature maps function names to their Jasmin name and their function type.
  sig0 = Map.fromList $ builtin ++ map sigEntry defs 
  sigEntry def@(DFun _ f@(Id x) _ _ ) = (f,) $ Fun (Id $ name ++ "/" ++ x ) $ funType def 
  -- | Header is fixed except for class @name@.
  header = concat
    [ [ ";; BEGIN HEADER"
      , ""
      , ".class public " ++ name
      , ".super java/lang/Object"
      , ""
      , ".method public <init>()V"
      , ".limit locals 1"
      -- Missing from example: ".limit stasck 1"
      , ""
      ]
    , map indent
      [ "aload_0"
      , "invokespecial java/lang/Object/<init>()V"
      , "return"
      ]
    , [ ""
      , ".end method"
      , ""
      , ".method public static main([Ljava/lang/String;)V"
      , ".limit locals 1"
      , ".limit stack  1"
      , ""
      ]
    , map indent
      [ "invokestatic " ++ name ++ "/main()I"
      , "pop"
      , "return"
      ]
    , [ ""
      , ".end method"
      , ""
      , ";; END HEADER"
      ]
    ]

-- | Indent non-empty lines.

indent :: String -> String
indent s = if null s then s else "\t" ++ s

compileDef :: Sig -> Def -> [String] 
compileDef sig0 def@(DFun t f args ss) = concat
    -- Output function header.
    [ [ ""
    , ".method public static " ++ toJVM (Fun f $ funType def)
    ]
    -- Output limits. 
    , [ ".limit locals " ++ show (limitLocals st) 
    , ".limit stack " ++ show (limitStack st ) 
    ]
    -- Output code. 
    , map (indent . toJVM) $ reverse (output st )
    -- Output function footer.
    , [ "" 
    , ".end method" 
    ]
    ]
    where
    st = execState (compileFun t args ss) $ initSt sig0 

-- | Compile a function, to be called in initial environment.

compileFun :: Type -> [Arg] -> [Stm] -> Compile ()
compileFun t args ss = do
    mapM_ (\ (ADecl t' x) -> newVar x t') args
    mapM_ compileStm ss
    -- Default return
    -- Push 0 on the stack, depending on t
    if t == Type_double then emit $ DConst 0.0 else
      if t /= Type_void then emit $ IConst 0
        else pure ()
    emit $ Return t

stmTop :: Stm -> String 
stmTop s = printTree s 

comment :: String -> Compile ()
comment s = emit $ Comment (";; " ++ s)

blank :: Compile () 
blank = emit $ Comment ""

-- | Compile a statement.

compileStm :: Stm -> Compile ()
compileStm s0 = do

  -- Output a comment with the statement to compile.
  let top = stmTop s0 
  unless (null top ) $ do 
    blank 
    mapM_ comment $ lines top 

  -- Compile the statement.
  case s0 of
    SDecls t (x:xs) -> do
      newVar x t
      when (xs /= []) $ compileStm (SDecls t xs) 
    SInit t x e -> do
      newVar x t
      compileExp e
      (a, t) <- lookupVar x
      emit $ Store t a
      emit $ Load t a
      when (t /= Type_void) $ emit $ Pop t
    SDecl t x -> do 
      newVar x t 
    SExp e t -> do
      compileExp e
      when (t /= Type_void) $ emit $ Pop t
    SReturn t e -> do
      compileExp e
      emit $ Return t
    SBlock b -> compileBlock b
    SWhile e s -> do 
      test <- newLabel 
      end <- newLabel 
      emit $ Label test
      compileExp e
      emit $ IConst 0
      emit $ IfCmp Type_bool OEq end
      compileBlock [s] 
      emit $ Goto test
      emit $ Label end 
    SIfElse e s1 s2 -> do
      done <- newLabel 
      false <- newLabel 
      compileExp e 
      emit $ IConst 0
      emit $ IfCmp Type_bool OEq false
      compileBlock [s1]
      emit $ Goto done 
      emit $ Label false
      compileBlock [s2] 
      emit $ Label done 

    s -> error $ "Not yet implemented: compileStm " ++ printTree s

-- | Compile a block.

compileBlock :: [Stm] -> Compile ()
compileBlock ss = do
  newBlock
  old <- gets currentStack
  mapM_ compileStm ss
  popBlock
  modify $ \st -> st { currentStack = old }

-- | Compile an expression to leave its value on the stack.

compileExp :: Exp -> Compile ()
compileExp = \case
    EBool b -> emit $ IConst $ if b == LTrue then 1 else 0
    EInt i -> emit $ IConst i
    EDouble d -> emit $ DConst d
    EId x -> do
      (a, t) <- lookupVar x
      emit $ Load t a
    EApp x es -> do
      mapM_ compileExp es
      m <- gets sig
      let f = Map.findWithDefault (error "undefined fun") x m
      emit $ Call f
    EPost x op -> do
      (a, t) <- lookupVar x
      emit $ Load t a
      emit $ Dup t
      emit $ if t == Type_double then DConst 1 else IConst 1
      emit $ if op == OInc then Add t OPlus else Add t OMinus 
      emit $ Store t a 
    EPre op x -> do
      (a, t) <- lookupVar x
      emit $ Load t a
      emit $ if t == Type_double then DConst 1 else IConst 1
      emit $ if op == OInc then Add t OPlus else Add t OMinus 
      emit $ Store t a 
      emit $ Load t a
    EMul t e1 op e2 -> do 
      compileExp e1
      compileExp e2
      emit $ Mul t op 
    EAdd t e1 op e2 -> do
      compileExp e1 
      compileExp e2
      emit $ Add t op 
    ECmp Type_double e1 op e2 -> do 
      done <- newLabel 
      false <- newLabel
      compileExp e1
      compileExp e2
      emit DCmp
      emit $ If (negateCmp op) false
      emit $ IConst 1
      emit $ Goto done
      emit $ Label false
      emit $ IConst 0
      emit $ Label done
    ECmp _ e1 op e2 -> do 
      done <- newLabel 
      false <- newLabel
      compileExp e1
      compileExp e2
      emit $ IfCmp Type_bool (negateCmp op) false
      emit $ IConst 1
      emit $ Goto done
      emit $ Label false
      emit $ IConst 0
      emit $ Label done
    EAnd e1 e2 -> do 
      done <- newLabel 
      false <- newLabel
      compileExp e1 
      emit $ IConst 0
      emit $ IfCmp Type_bool OEq false 
      compileExp e2
      emit $ IConst 0
      emit $ IfCmp Type_bool OEq false       
      emit $ IConst 1
      emit $ Goto done
      emit $ Label false 
      emit $ IConst 0 
      emit $ Label done
    EOr e1 e2 -> do 
      true <- newLabel 
      done <- newLabel 
      compileExp e1 
      emit $ IConst 1
      emit $ IfCmp Type_bool OEq true
      compileExp e2
      emit $ IConst 1
      emit $ IfCmp Type_bool OEq true 
      emit $ IConst 0
      emit $ Goto done
      emit $ Label true
      emit $ IConst 1 
      emit $ Label done
    EAss x e -> do
      compileExp e
      (a, t) <- lookupVar x
      emit $ Store t a
      emit $ Load t a
    EI2D e -> do
      compileExp e
      emit $ I2D

    e -> error $ "Not yet implemented: compileExp " ++ printTree e

-- * Labels 

newLabel :: Compile Label 
newLabel = do 
  l <- gets nextLabel 
  modify $ \ st -> st { nextLabel = succ l }
  return $ l 

newVar :: Id -> Type -> Compile () 
newVar x t = do
  modify $ \ st@St{ cxt = (b:bs) } -> st { cxt = ((x, t) : b) : bs }
  updateLimitLocals 

-- | Return address and type of variable. 
lookupVar :: Id -> Compile (Addr, Type) 
lookupVar x = loop . concat <$> gets cxt 
  where 
  loop [] = error $ "unbound variable " ++ printTree x 
  loop ((y,t) : bs ) 
    | x == y    = (size bs, t ) 
    | otherwise = loop bs 

updateLimitLocals :: Compile () 
updateLimitLocals = do 
  old <- gets limitLocals
  bs <- gets cxt
  modify $ \ st -> st { limitLocals = max (size bs) old}
  
updateStack :: Code -> Compile () 
updateStack c = do
  s <- gets currentStack
  let stack = s + size c
  limit <- gets limitStack
  modify $ \st -> st 
    { currentStack = stack
    , limitStack = max stack limit }

emit :: Code -> Compile () 
emit code = do 
  updateStack code
  modify $ \ st@St{ output = out } -> st { output = code : out}

newBlock :: Compile ()
newBlock = modify $ \ st@St{ cxt = (c) } -> st { cxt = []:c }

popBlock :: Compile ()
popBlock = modify $ \ st@St{ cxt = (_:bs) } -> st { cxt = bs }

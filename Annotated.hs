{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- | The annotated version of abstract syntax of language CMM.

module Annotated (
  module Annotated
  , Id(..), Type(..), Arg(..), CmpOp(..), IncDecOp(..), MulOp(..), AddOp(..), BoolLit(..)
  , Print(..), printTree
  ) where

-- import Prelude hiding (exp)

import CMM.Abs (Id(..), Type(..), Arg(..), CmpOp(..), IncDecOp(..), MulOp(..), AddOp(..), BoolLit(..) )
import CMM.Print

data Program = PDefs [Def]
  deriving (Eq, Ord, Show, Read)

data Def = DFun Type Id [Arg] [Stm]
  deriving (Eq, Ord, Show, Read)

data Stm
    = SExp Exp Type
    | SDecls Type [Id]
    | SDecl Type Id 
    | SInit Type Id Exp
    | SReturn Type Exp 
    | SWhile Exp Stm
    | SBlock [Stm]
    | SIfElse Exp Stm Stm
    | SThrow Exp
    | STryCatch [Stm] Type Id [Stm]
  deriving (Eq, Ord, Show, Read)

data Exp
    = EBool BoolLit 
    | EInt Integer
    | EDouble Double
    | EId Id
    | EApp Id [Exp]
    | EPost Id IncDecOp 
    | EPre  IncDecOp Id 
    | EMul Type Exp MulOp Exp 
    | EAdd Type Exp AddOp Exp 
    | ECmp Type Exp CmpOp Exp 
    | EAnd Exp Exp
    | EOr Exp Exp
    | EAss Id Exp
    | EI2D Exp
  deriving (Eq, Ord, Show, Read)


-- | 'printTree' instances for the annotated syntax (useful for debugging).

instance Print Program where
  prt i = \case
    PDefs defs -> prPrec i 0 (concatD [prt 0 defs])

instance Print Def where
  prt i = \case
    DFun type_ id_ args stms -> prPrec i 0 (concatD [prt 0 type_, prt 0 id_, doc (showString "("), prt 0 args, doc (showString ")"), doc (showString "{"), prt 0 stms, doc (showString "}")])

instance Print [Def] where
  prt _ [] = concatD []
  prt _ (x:xs) = concatD [prt 0 x, prt 0 xs]

-- instance Print Arg where
--   prt i = \case
--     ADecl type_ id_ -> prPrec i 0 (concatD [prt 0 type_, prt 0 id_])
--
-- instance Print [Arg] where
--   prt _ [] = concatD []
--   prt _ [x] = concatD [prt 0 x]
--   prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Stm where
  prt i = \case
    SExp exp _ -> prPrec i 0 (concatD [prt 0 exp, doc (showString ";")])
    SDecls type_ ids -> prPrec i 0 (concatD [doc (showString "let"), prt 0 type_, prt 0 ids, doc (showString ";")])
    SInit type_ id_ exp -> prPrec i 0 (concatD [doc (showString "let"), prt 0 type_, prt 0 id_, doc (showString "="), prt 0 exp, doc (showString ";")])
    SDecl type_ id_ -> prPrec i 0 (concatD [prt 0 type_, prt 0 id_, doc (showString ";")])
    SReturn type_ exp -> prPrec i 0 (concatD [doc (showString "return"), prt 0 type_, prt 0 exp, doc (showString ";")]) --Added type
    SWhile exp stm -> prPrec i 0 (concatD [doc (showString "while"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm])
    SBlock stms -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stms, doc (showString "}")])
    SIfElse exp stm1 stm2 -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm1, doc (showString "else"), prt 0 stm2])
    SThrow exp -> prPrec i 0 (concatD [doc (showString "throw"), prt 0 exp, doc (showString ";")])
    STryCatch stms1 type_ id_ stms2 -> prPrec i 0 (concatD [doc (showString "try"), doc (showString "{"), prt 0 stms1, doc (showString "}"), doc (showString "catch"), doc (showString "("), prt 0 type_, prt 0 id_, doc (showString ")"), doc (showString "{"), prt 0 stms2, doc (showString "}")])

instance Print [Stm] where
  prt _ [] = concatD []
  prt _ (x:xs) = concatD [prt 0 x, prt 0 xs]

instance Print Exp where
  prt i = \case
    EBool boollit -> prPrec i 6 (concatD [prt 0 boollit])
    EInt n -> prPrec i 6 (concatD [prt 0 n])
    EDouble d -> prPrec i 6 (concatD [prt 0 d])
    EId id_ -> prPrec i 6 (concatD [prt 0 id_])
    EApp id_ exps -> prPrec i 6 (concatD [prt 0 id_, doc (showString "("), prt 0 exps, doc (showString ")")])
    EPost id_ incdecop -> prPrec i 6 (concatD [prt 0 id_, prt 0 incdecop])
    EPre incdecop id_ -> prPrec i 6 (concatD [prt 0 incdecop, prt 0 id_])
    EMul type_ exp1 mulop exp2 -> prPrec i 5 (concatD [prt 0 type_, prt 5 exp1, prt 0 mulop, prt 6 exp2])
    EAdd type_ exp1 addop exp2 -> prPrec i 4 (concatD [prt 0 type_, prt 4 exp1, prt 0 addop, prt 5 exp2])
    ECmp type_ exp1 cmpop exp2 -> prPrec i 3 (concatD [prt 0 type_, prt 4 exp1, prt 0 cmpop, prt 4 exp2])
    EAnd exp1 exp2 -> prPrec i 2 (concatD [prt 2 exp1, doc (showString "&&"), prt 3 exp2])
    EOr exp1 exp2 -> prPrec i 1 (concatD [prt 1 exp1, doc (showString "||"), prt 2 exp2])
    EAss id_ exp -> prPrec i 0 (concatD [prt 0 id_, doc (showString "="), prt 0 exp])
    EI2D exp -> prPrec i 0 (concatD [doc (showString "(double)"), prt 0 exp])

instance Print [Exp] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

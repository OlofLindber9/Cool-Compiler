-- Programming Language Technology (Chalmers DAT151 / GU DIT231)
-- (C) 2022-24 Andreas Abel
-- All rights reserved.

{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- | The annotated version of abstract syntax of language CMM.

module Annotated where

import Prelude hiding (exp)

import CMM.Abs (Id(..), Type(..), Arg(..), CmpOp(..), IncDecOp(..), MulOp(..), AddOp(..), BoolLit(..))
import CMM.Print

-- The following is a copy of content from CMM.Abs.
--
-- TODO: Change this to type-annotated syntax trees.
--
-- In essence this amounts to:
--
--   * Adding 'Type' fields to some of the constructors.
--   * Possibly adding an expression constructor to convert from 'int' to 'double'.
--
-- However, you might want to also restructure expressions (and statements etc.)
-- to better fit the need of the interpreter.
-- (E.g., 'EMul' and 'EAdd' could be fused to 'EArithOp' etc.)

data Program = PDefs [Def]
  deriving Show

data Def = DFun Type Id [Arg] [Stm]
  deriving Show

data Stm
    = SExp Exp
    | SDecls Type [Id]
    | SInit Type Id Exp
    | SReturn Exp
    | SWhile Exp Stm
    | SBlock [Stm]
    | SIfElse Exp Stm Stm
  deriving Show

data Exp
    = EBool BoolLit
    | EInt Integer
    | EDouble Double
    | EId Id
    | EApp Id [Exp]
    | EPost Id IncDecOp
    | EPre IncDecOp Id
    | EMul Exp MulOp Exp
    | EAdd Exp AddOp Exp
    | ECmp Exp CmpOp Exp
    | EAnd Exp Exp
    | EOr Exp Exp
    | EAss Id Exp
  deriving Show

-- The following is a copy of the generated printer CMM.Print,
-- implementing 'printTree' for the annotated syntax.
-- (Could be useful for debugging.)
--
-- TODO: Update this as you modify the data types above.
-- If you do not want 'printTree' for the annotated syntax,
-- you can discard this code.

instance Print Program where
  prt i = \case
    PDefs defs -> prPrec i 0 (concatD [prt 0 defs])

instance Print Def where
  prt i = \case
    DFun type_ id_ args stms -> prPrec i 0 (concatD [prt 0 type_, prt 0 id_, doc (showString "("), prt 0 args, doc (showString ")"), doc (showString "{"), prt 0 stms, doc (showString "}")])

instance Print [Def] where
  prt _ [] = concatD []
  prt _ (x:xs) = concatD [prt 0 x, prt 0 xs]

instance Print Stm where
  prt i = \case
    SExp exp -> prPrec i 0 (concatD [prt 0 exp, doc (showString ";")])
    SDecls type_ ids -> prPrec i 0 (concatD [prt 0 type_, prt 0 ids, doc (showString ";")])
    SInit type_ id_ exp -> prPrec i 0 (concatD [prt 0 type_, prt 0 id_, doc (showString "="), prt 0 exp, doc (showString ";")])
    SReturn exp -> prPrec i 0 (concatD [doc (showString "return"), prt 0 exp, doc (showString ";")])
    SWhile exp stm -> prPrec i 0 (concatD [doc (showString "while"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm])
    SBlock stms -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stms, doc (showString "}")])
    SIfElse exp stm1 stm2 -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm1, doc (showString "else"), prt 0 stm2])

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
    EMul exp1 mulop exp2 -> prPrec i 5 (concatD [prt 5 exp1, prt 0 mulop, prt 6 exp2])
    EAdd exp1 addop exp2 -> prPrec i 4 (concatD [prt 4 exp1, prt 0 addop, prt 5 exp2])
    ECmp exp1 cmpop exp2 -> prPrec i 3 (concatD [prt 4 exp1, prt 0 cmpop, prt 4 exp2])
    EAnd exp1 exp2 -> prPrec i 2 (concatD [prt 2 exp1, doc (showString "&&"), prt 3 exp2])
    EOr exp1 exp2 -> prPrec i 1 (concatD [prt 1 exp1, doc (showString "||"), prt 2 exp2])
    EAss id_ exp -> prPrec i 0 (concatD [prt 0 id_, doc (showString "="), prt 0 exp])

instance Print [Exp] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

-- Programming Language Technology (Chalmers DAT151 / GU DIT231)
-- (C) 2022-24 Andreas Abel
-- All rights reserved.

{-# OPTIONS_GHC -Wno-unused-imports #-} -- Turn off unused import warning off in stub

module TypeChecker where

import Control.Monad
import Control.Monad.Except

import Data.Map (Map)
import qualified Data.Map as Map

import CMM.Abs
import CMM.Print (printTree)

import qualified Annotated as A

type TypeError = String

typecheck :: Program -> Either TypeError A.Program
typecheck p = throwError "type checker not yet implemented"

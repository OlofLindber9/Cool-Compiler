-- Programming Language Technology (Chalmers DAT151 / GU DIT231)
-- (C) 2022-24 Andreas Abel
-- All rights reserved.

{-# OPTIONS_GHC -Wno-unused-imports #-} -- Turn off unused import warning off in stub

module TypeChecker where

import Control.Monad
import Control.Monad.Except

import Data.Functor
import Data.Map (Map)
import qualified Data.Map as Map

import CMM.Abs
import CMM.Print (Print, printTree)

import qualified Annotated as A

type TypeError = String

data FunType = FunType
  { resultType :: Type
  , argTypes   :: [Type]
  }

type Sig = Map Id FunType
type Cxt = [Block] -- nonempty
type Block = Map Id Type

typecheck :: Program -> Either TypeError A.Program
typecheck (PDefs ds) = do

  -- Pass 1: produce table of functions
  -- We need to check for duplicate functions
  sig <- buildMap $
     [(Id "printInt", FunType Type_void [Type_int]),
     (Id "printDouble", FunType Type_void [Type_double]),
     (Id "readInt", FunType Type_int []),
     (Id "readDouble", FunType Type_double [])] ++
     map (\ (DFun t x args _) -> (x, FunType t $ map (\ (ADecl t' _) -> t') args)) ds
  -- Pass 2: check all definitions
  ds' <- mapM (checkDef sig) ds

  -- Check for main
  case Map.lookup (Id "main") sig of
    Just (FunType Type_int []) -> pure ()
    _ -> throwError $ "no or wrong main"

  return (A.PDefs ds')

checkDef :: Sig -> Def -> Either TypeError A.Def
checkDef sig d@(DFun t x args ss) = do
  checkParameters args
  block <- buildMap $ map (\ (ADecl t' x') -> (x', t')) args
  let cxt = [block]
  (ss', _cxt) <- checkStms sig t cxt ss
  return $ A.DFun t x args ss'

checkStms :: Sig -> Type -> Cxt -> [Stm] -> Either TypeError ([A.Stm], Cxt)
checkStms sig returnType cxt = \case
  [] -> return ([], cxt)
  s : ss -> do
    (s', cxt1) <- checkStm sig returnType cxt s
    (ss', cxt2) <- checkStms sig returnType cxt1 ss
    return (s':ss', cxt2)

checkStm :: Sig -> Type -> Cxt -> Stm -> Either TypeError (A.Stm, Cxt)
checkStm sig returnType cxt = \case
  SInit t x e -> do
    when (t == Type_void) $ throwError "variable declared with type void" 
    cxt1 <- addVar x t cxt
    e' <- checkExp sig cxt1 e t
    return (A.SInit t x e', cxt1)

  SExp e -> do
    (e', t) <- inferExp sig cxt e
    return (A.SExp e' t, cxt)

  SDecls t xs -> do
    when (t == Type_void) $ throwError "variable declared with type void"
    cxt' <- foldM (\ctx x -> addVar x t ctx) cxt xs
    return (A.SDecls t xs, cxt')

  SReturn e -> do
    e' <- checkExp sig cxt e returnType
    return (A.SReturn returnType e', cxt)

  SBlock ss -> do
    let newCxt = Map.empty
    let cxt1 = newCxt : cxt
    (ss', cxt2) <- checkStms sig returnType cxt1 ss
    let cxt' = tail cxt2
    return (A.SBlock ss', cxt')

  SWhile e s -> do
    e' <- checkExp sig cxt e Type_bool
    let newCxt = Map.empty
    let cxt1 = newCxt : cxt
    (s', cxt') <- checkStm sig returnType cxt1 s 
    return (A.SWhile e' s', cxt)

  SIfElse e s1 s2 -> do
    e' <- checkExp sig cxt e Type_bool
    let newCxt = Map.empty
    let cxt1 = newCxt : cxt
    (s1', cxt') <- checkStm sig returnType cxt1 s1 
    let cxt2 = newCxt : cxt
    (s2', cxt') <- checkStm sig returnType cxt2 s2 
    return (A.SIfElse e' s1' s2', cxt)
    
  s -> nyi s

checkExp :: Sig -> Cxt -> Exp -> Type -> Either TypeError A.Exp
checkExp sig cxt e t = do
  (e', t') <- inferExp sig cxt e
  coerce t' t e'

coerce :: Type -> Type -> A.Exp -> Either TypeError A.Exp
coerce t1 t2 e = case (t1, t2) of
  _ | t1 == t2 -> return e
  (Type_int, Type_double) -> return $ A.EI2D e
  (Type_double, Type_int) -> return e
  _ -> throwError "type mismatch"

inferExp :: Sig -> Cxt -> Exp -> Either TypeError (A.Exp, Type)
inferExp sig cxt = \case
  EBool b -> return (A.EBool b, Type_bool)
  EDouble d -> return (A.EDouble d, Type_double)
  EInt i -> return (A.EInt i, Type_int)

  EId x  -> do
    t <- lookupVar x cxt
    return (A.EId x, t)

  EApp f es -> do
    case Map.lookup f sig of
      Nothing -> throwError "unbound function"
      Just (FunType t ts) -> do
        es' <- checkArgs sig cxt es ts
        return (A.EApp f es', t)

  EPost x op -> do
    t <- lookupVar x cxt
    case t of
      Type_bool -> throwError "cannot inc/dec bool"
      Type_void -> throwError "cannot inc/dec void"
      _         -> return (A.EPost x op, t)

  EPre op x -> do
    t <- lookupVar x cxt
    case t of
      Type_bool -> throwError "cannot inc/dec bool"
      Type_void -> throwError "cannot inc/dec void"
      _         -> return (A.EPre op x, t)

  EMul e1 op e2 -> do
    (e1', t1) <- inferExp sig cxt e1
    (e2', t2) <- inferExp sig cxt e2
    e1'' <- coerce t1 t2 e1'
    e2'' <- coerce t2 t1 e2'
    if t1 == t2 
      then return (A.EMul t2 e1'' op e2'', t2)
      else return (A.EMul Type_double e1'' op e2'', Type_double) 

  EAdd e1 op e2 -> do
    (e1', t1) <- inferExp sig cxt e1
    (e2', t2) <- inferExp sig cxt e2
    e1'' <- coerce t1 t2 e1'
    e2'' <- coerce t2 t1 e2'
    if t1 == t2 
      then return (A.EAdd t2 e1'' op e2'', t2)
      else return (A.EAdd Type_double e1'' op e2'', Type_double) 

  ECmp e1 op e2 -> do
    (e1', t1) <- inferExp sig cxt e1
    (e2', t2) <- inferExp sig cxt e2
    e1'' <- coerce t1 t2 e1'
    e2'' <- coerce t2 t1 e2'
    case (t1, t2) of 
      _ | t1 == t2 -> return (A.ECmp t2 e1'' op e2'', Type_bool)
      _            -> return (A.ECmp Type_double e1'' op e2'', Type_bool)

  EAnd e1 e2 -> do 
    (e1', t1) <- inferExp sig cxt e1
    (e2', t2) <- inferExp sig cxt e2
    if t1 == Type_bool && t2 == Type_bool
      then return (A.EAnd e1' e2', Type_bool)
      else throwError "can only execute conjuction on boolean types"

  EOr e1 e2 -> do 
    (e1', t1) <- inferExp sig cxt e1
    (e2', t2) <- inferExp sig cxt e2
    if t1 == Type_bool && t2 == Type_bool
      then return (A.EOr e1' e2', Type_bool)
      else throwError "can only execute conjuction on boolean types"
  
  EAss x e -> do
    t <- lookupVar x cxt
    (e', t') <- inferExp sig cxt e 
    e'' <- coerce t' t e'
    return (A.EAss x e'', t)


checkArgs :: Sig -> Cxt -> [Exp] -> [Type] -> Either TypeError [A.Exp]
checkArgs sig cxt = curry $ \case
  ([],[]) -> return []
  (e:es, t:ts) -> do
    e' <- checkExp sig cxt e t
    es' <- checkArgs sig cxt es ts
    return (e' : es')
  _ -> throwError "incorrect number of arguments"

checkParameters :: [Arg] -> Either TypeError ()
checkParameters [] = return ()
checkParameters (ADecl t id : args) = do
  if t == Type_void 
    then throwError "cannot have parameter of type void"
    else checkParameters args

-- * Auxiliary functions

nyi :: (MonadError TypeError m, Print a) => a -> m b
nyi a = throwError $ unwords ["not yet implemented:", printTree a]

buildMap :: [(Id, t)] -> Either TypeError (Map Id t)
buildMap decls = foldM addEntry Map.empty decls

addEntry :: Map Id t -> (Id, t) -> Either TypeError (Map Id t)
addEntry m (x, t) =
  case Map.lookup x m of
    Just{} -> throwError $ unwords ["duplicate declaration:", printTree x]
    Nothing -> return $ Map.insert x t m

addVar :: Id -> Type -> Cxt -> Either TypeError Cxt
addVar x t (b : bs) = do
  b' <- addEntry b (x, t)
  return (b' : bs) 


lookupVar :: Id -> Cxt -> Either TypeError Type
lookupVar x = \case
  [] -> throwError $ unwords [ "unbound variable:", printTree x]
  b:bs -> case Map.lookup x b of 
    Just t -> return t
    Nothing -> lookupVar x bs

isIncompatible :: Type -> Type -> Bool
isIncompatible t1 t2 =
  (t1 == Type_bool && (t2 == Type_int || t2 == Type_double))|| 
  (t2 == Type_bool && (t1 == Type_int || t1 == Type_double))
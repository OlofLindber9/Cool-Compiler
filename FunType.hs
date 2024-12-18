module FunType where

-- import CMM.Abs
import Annotated 

data FunType = FunType { funRet :: Type, funPars :: [Type] }
    deriving Show

funType :: Def -> FunType
funType (DFun rt _f args _ss) = FunType rt $ map (\ (ADecl t _) -> t ) args 

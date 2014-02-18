module Program.Simple.Pretty 
 ( prettyProgram
 ) where

import Program.Simple.Base

prettyProgram :: Program -> String
prettyProgram p
 =  "\\"      ++ pNames (_pInputs p)  ++ "\n"
 ++    concatMap pBind  (_pBinds p)
 ++ "return " ++ pNames (_pOutputs p) ++ "\n"
 where
  pNames (as,ss)
   =  concatMap ((++" ") . pAId) as
   ++ concatMap ((++" ") . pSId) ss

  pBind (ABind i x)
   = pAId i ++ " = " ++ pAX x ++ "\n"
  pBind (SBind i x)
   = pSId i ++ " = " ++ pSX x ++ "\n"

  pAX (MapN f ins)
   = "map#" ++ show (length ins) ++ "    " ++ pFun f ++ " " ++ pNames (ins,[])
  pAX (Filter f in1)
   = "filter   " ++ pFun f ++ " " ++ pAId in1
  pAX (BPermute in1 in2)
   = "bpermute " ++ pAId in1 ++ " " ++ pAId in2

  pSX (Reduce f in1)
   = "reduce   " ++ pFun f ++ " " ++ pAId in1

  pFun (Fun ss)
   = "(\\..{" ++ pNames ([],ss) ++ "})"

  pAId (AId a)
   = "a" ++ show a
  pSId (SId a)
   = "s" ++ show a

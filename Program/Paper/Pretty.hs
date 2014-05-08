module Program.Paper.Pretty 
 ( prettyProgram
 ) where

import Common.Pretty
import Program.Paper.Base

instance Pretty Program where
 ppr = prettyProgram

instance Pretty AId where
 ppr (AId a)
  = "a" ++ show a
instance Pretty SId where
 ppr (SId a)
  = "s" ++ show a

instance Pretty Fun where
 ppr (Fun ss)
  = "(\\..{" ++ pNames ([],ss) ++ "})"

instance Pretty Bind where
 ppr (ABind i x)
  = ppr i ++ " = " ++ ppr x ++ "\n"
 ppr (SBind i x)
  = ppr i ++ " = " ++ ppr x ++ "\n"
 ppr (External (outA,outS) (inA,inS))
  = pNames (outA,outS) ++ " = external " ++ pNames (inA,inS) ++ "\n"

instance Pretty AExp where
  ppr (MapN f ins)
   = "map#" ++ show (length ins) ++ "    " ++ ppr f ++ " " ++ pNames (ins,[])
  ppr (Filter f in1)
   = "filter   " ++ ppr f ++ " " ++ ppr in1
  ppr (BPermute in1 in2)
   = "bpermute " ++ ppr in1 ++ " " ++ ppr in2
  ppr (Generate s f)
   = "generate " ++ ppr s ++ " " ++ ppr f
  ppr (Cross in1 in2)
   = "cross " ++ ppr in1 ++ " " ++ ppr in2

instance Pretty SExp where
  ppr (Reduce f in1)
   = "reduce   " ++ ppr f ++ " " ++ ppr in1

pNames :: ([AId], [SId]) -> String
pNames (as,ss)
 =  concatMap ((++" ") . ppr) as
 ++ concatMap ((++" ") . ppr) ss


prettyProgram :: Program -> String
prettyProgram p
 =  "\\"      ++ pNames (_pInputs p)  ++ "\n"
 ++    concatMap ppr  (_pBinds p)
 ++ "return " ++ pNames (_pOutputs p) ++ "\n"
 where

module Linear.Pretty where

import Data.LinearProgram
import qualified Data.List as List
import qualified Data.Map  as Map

pprLP :: (Show v, Show c) => LP v c -> String
pprLP p
 =     minMax ++ obj
 ++ "\nSubject to\n"
 ++    constrs
 where
  minMax
   = case direction p of
     Min -> "Minimise "
     Max -> "Maximise "
  obj
   = pprLF $ objective p

  constrs
   = List.intercalate "\n"
   $ map shoCo $ constraints p

  shoCo (Constr name lf bound)
   =  pprPad  90 (pprLF lf)
   ++ pprPad  5 (shoBo bound)
   ++ maybe "" (": "++) name 

  shoBo b
   = case b of
     Free       -> " ?? "
     LBound a   -> ">= " ++ show a
     UBound a   -> "<= " ++ show a
     Equ    a   -> "== " ++ show a
     Bound  l u -> ">= " ++ show l ++ " <=  " ++ show u

  


pprLF :: (Show v, Show c) => LinFunc v c -> String
pprLF lf
 = List.intercalate " + "
 $ map sho
 $ Map.toList lf
 where
  sho (v,c)
   = show c ++ "*" ++ show v


pprPad :: Int -> String -> String
pprPad to str
 | l >= to
 = str
 | otherwise
 = str ++ replicate (to - l) ' '
 where
  l = length str
   

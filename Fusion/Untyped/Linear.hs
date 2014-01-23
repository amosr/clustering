module Fusion.Untyped.Linear
 (solve_linear
 ) where

import Graph
import Fusion.Untyped.Traversal

import qualified Data.Map as Map
import           Data.Map   (Map)

import Control.Monad.LPMonad
import Data.LinearProgram
--import Data.LinearProgram.GLPK

import System.IO.Unsafe (unsafePerformIO)
-- import Debug.Trace

-- | Variable type for linear program
-- Cluster    - {0..} all nodes with same number are clustered together
-- Contracted - {0,1}, 0 if given node is fully contracted
-- MaxCluster - {0..} maximum of all cluster numbers
data GVar k
 = Cluster k
 | Contracted k
 | MaxCluster
 deriving (Eq, Show, Ord)

-- | Minimise objective:
-- \Sigma_i Contracted(i)
-- The goal is to find a clustering that contracts the most number of arrays
gobjective :: Ord k => [k] -> LinFunc (GVar k) Int
gobjective ns
 =  linCombination
 $  map (\k -> (1, Contracted k)) ns
 ++ [(length ns, MaxCluster)]


-- | Set variable types - Cluster are integers, Contracted are bools
setKinds :: Ord k => [k] -> LPM (GVar k) Int ()
setKinds ns
 = do   mapM_ set ns

        varGeq     (MaxCluster)   0
        setVarKind (MaxCluster)   IntVar
 where
  set n
   = do varGeq     (Cluster n)    0
        varGeq     (Contracted n) 0
        setVarKind (Cluster n)    IntVar
        setVarKind (Contracted n) BinVar


-- | Create constraints for
addConstraints :: Ord k => Int -> [((k,k),Bool)] -> LPM (GVar k) Int ()
addConstraints bigN arcs
 = mapM_ add arcs
 where
  add ((u,v),fusible)
   | fusible
   = do geqTo (var (Cluster v) ^-^ var (Cluster u)) 0
        geqTo (bigN *^ var (Contracted u) ^-^ (var (Cluster v) ^-^ var (Cluster u))) 0
   | otherwise
   = do geqTo (var (Cluster v) ^-^ var (Cluster u)) 1

addMaxConstraints :: Ord k => [k] -> LPM (GVar k) Int ()
addMaxConstraints names
 = mapM_ add names
 where
  add n
   = geq (var MaxCluster) (var (Cluster n))

-- | Create program for graph
lp :: Ord k => Graph' k -> LP (GVar k) Int
lp g
 = execLPM
 $ do   setDirection Min
        setObjective $ gobjective names

        addConstraints numNodes arcs
        addMaxConstraints names

        setKinds names
 where
   names
     = map fst $ fst $ listOfGraph g
   arcs
     =           snd $ listOfGraph g

   numNodes
     = length names

solve_linear :: (Show k, Ord k) => Graph' k -> Map k Int
solve_linear g
 -- GLPK has a fit if we give it a problem with no constraints
 | null names || null arcs
 = foldl (\m n -> Map.insert n 0 m) Map.empty names 

 | otherwise
 = let lp'  = lp g
       opts'= mipDefaults { msgLev = MsgOff }
       res  = unsafePerformIO $ glpSolveVars opts' lp' -- $ trace (show lp') lp'
   in  case res of
        (Success, Just (_, m))
         -> fixMap m
        _
         -> error (show res)
 where
  fixMap m
   = Map.foldWithKey go Map.empty m

  go k v m
   | Cluster n <- k
   = Map.insert n (truncate v) m
   | otherwise
   = m

  names
     = map fst $ fst $ listOfGraph g
  arcs
     =           snd $ listOfGraph g

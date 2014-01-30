module Fusion.Typed.Linear2
 (solve_linear_minnodes
 ) where

import Graph
import Fusion.Typed.Base

import qualified Data.Map as Map
--import           Data.Map   (Map)

import Control.Monad.LPMonad
import Data.LinearProgram
--import Data.LinearProgram.GLPK

import System.IO.Unsafe (unsafePerformIO)
-- import Debug.Trace

-- | Variable type for linear program
-- Pi i             - {0..} used to show the resulting partition is acyclic:
--
--      A graph is acyclic iff there is a mapping
--          pi : Node -> Int
--      such that \forall (i,j) \in Edge
--          pi(j) > pi(i)
--
-- SameCluster i j  - {0,1} 0 if i and j are fused together
data GVar k
 = Pi k
 | SameCluster k k
 deriving (Eq, Show, Ord)

-- | Minimise objective:
-- \Sigma_i,j Weight(i,j) * SameCluster(i,j)
gobjective :: Ord k => [(Int,k,k)] -> LinFunc (GVar k) Int
gobjective ws
 =  linCombination
 $  map (\(w,i,j) -> (w, SameCluster i j)) ws


-- | Set variable types - Pi are integers, SameCluster are bools
setKinds :: Ord k => [k] -> [(Int,k,k)] -> LPM (GVar k) Int ()
setKinds ns ws
 = do   mapM_ setP ns
        mapM_ setW ws
 where
  setP n
   = do varGeq     (Pi n) 0
        setVarKind (Pi n) IntVar
  setW (_,i,j)
   = do varGeq     (SameCluster i j) 0
        setVarKind (SameCluster i j) BinVar


-- | Create constraints for edges and weights
addConstraints :: Ord k
               => Int -> Graph' k
               -> [((k,k),Bool)]
               -> [(Int,k,k)]
               -> LPM (GVar k) Int ()
addConstraints bigN g arcs ws
 = do   mapM_ addP arcs
        mapM_ addW ws
 where
  -- Edge constraints:
  --
  -- For nonfusible edges (u,v), add a constraint
  --    pi(v) - pi(u) >= 1
  -- which is equivalent to
  --    pi(v) > pi(u)
  -- or "v must be scheduled after u"
  -- This will disallow u and v from being in the same cluster, as other
  -- constraints require x(u,v) = 0 can only be true if pi(u) = pi(v).
  --
  -- For fusible edges (u,v)
  --    if they are merged together,    x(u,v) = 0 and pi(v) = pi(u)
  --    otherwise,                      x(u,v) = 1 and pi(v) > pi(u)
  -- This is achieved with the constraint
  --    x(u,v) <= pi(v) - pi(u) <= n * x(u,v)
  --
  --
  -- Note that arcs are reversed in graph, so (v,u) below is actually an edge from u to v.
  addP ((v,u), fusible)
   -- Fusible and between same type
   | Just uT <- nodeAttribute g u
   , Just vT <- nodeAttribute g v
   , fusible && uT == vT
   = do let pis = var (Pi v) ^-^ var (Pi u)
        let x   = var (SameCluster u v)
        -- x(u,v)         <= pi(v) - pi(u)
        leq x    pis
        -- pi(v) - pi(u)  <= n * x(u,v)
        leq pis (bigN *^ x)

   -- Non-fusible edge, or nodes are different types
   | otherwise
        -- pi(v) - pi(u) >= 1
   = geqTo (var (Pi v) ^-^ var (Pi u)) 1


  -- Weights between other nodes:
  --
  -- For any two nodes that may be scheduled together,
  -- we must make sure that if they are together, their pis *must* be the same.
  -- If they are not together, their pis are unconstrained.
  --
  --    -n * x(u,v) <= pi(v) - pi(u) <= n * x(u,v)
  --
  -- That is, if u and v are in the same cluster (x(u,v)=0)
  -- then     pi(v) - pi(u) = 0, or pi(v) = pi(u)
  --
  -- Otherwise, pi(v) - pi(u) has a large enough range to be practically unbounded.
  -- 
  -- This constraint is not necessary if there is a fusible edge between the two,
  -- as a more restrictive constraint will be added by addP, but it does not
  -- conflict so it can be added anyway.
  --
  addW (_,u,v)
   = do let pis = var (Pi v) ^-^ var (Pi u)
        let x   = var (SameCluster u v)
        leq ((-bigN) *^ x) pis
        leq pis  (bigN *^ x)


-- | Get list of all nodes that might be clustered together,
-- and the weighted benefit of doing so.
clusterings :: Ord k => [((k,k),Bool)] -> [(k,Type)] -> [(Int, k,k)]
clusterings arcs ns
 = go ns
 where
   -- For some node, find all later nodes of same type, and calculate benefit
   go ((u,ty):rest)
    =  [ (weight u v,u,v)
       | (v,ty') <- rest, ty == ty']
    ++ go rest
   go []
    = []

   -- Simple trick:
   -- if there is an edge between the two,
   --   there will be some cache locality benefit from merging
   -- otherwise, 
   --   the only benefit is reducing loop overhead
   --
   -- Another heuristic would be to count nodes with shared parents as having a locality benefit
   weight u v
    | (_:_) <- filter (\((i,j),_) -> (u,v) == (i,j) || (v,u) == (i,j)) arcs
    = 5
    | otherwise
    = 1
   


-- | Create linear program for graph, and put all the pieces together.
lp :: Ord k => Graph' k -> LP (GVar k) Int
lp g
 = execLPM
 $ do   setDirection Min
        setObjective $ gobjective weights
        addConstraints numNodes g arcs weights
        setKinds names weights
 where
   g'    = listOfGraph g
   names = map fst $ fst g'
   arcs  =           snd g'

   -- TODO
   weights = mkWeights $ fst g'

   numNodes
     = length names

solve_linear_minnodes :: (Show k, Ord k) => Graph' k -> Clustering k
solve_linear_minnodes g
 -- GLPK has a fit if we give it a problem with no constraints
 | null $ constraints lp'
 = Map.fromList
   [ (k, (ty,n))
   | ((k,ty),n) <- (fst $ listOfGraph g) `zip` [0..]]

 | otherwise
 = let opts'= mipDefaults { msgLev = MsgOff }
       res  = unsafePerformIO $ glpSolveVars opts' lp' -- $ trace (show lp') lp'
   in  case res of
        (Success, Just (_, m))
         -> fixMap m
        _
         -> error (show res)
 where
  lp'  = lp g

  fixMap m
   = snd $ fill $ Map.foldWithKey go (0, Map.empty) m

  go k v (n, m)
   | SameCluster i j <- k
   , 0               <- v
   , Just ty         <- nodeAttribute g i
   , Just ty'        <- nodeAttribute g j
   , ty == ty'
   = case (Map.lookup i m, Map.lookup j m) of
     (Just _, Just _)
      -> (n, m)
     (Just iC, Nothing)
      -> (n, Map.insert j iC m)
     (Nothing, Just jC)
      -> (n, Map.insert i jC m)
     (Nothing, Nothing)
      -> ( n + 1
         , Map.insert i (ty, n) 
         $ Map.insert j (ty, n) m)

   | otherwise
   = (n, m)

  fill (n, m)
   = foldr goFill (n, m) (fst $ listOfGraph g)

  goFill (k,ty) (n, m)
   | Map.member k m
   = (n, m)
   | otherwise
   = ( n + 1
     , Map.insert k (ty, n) m)


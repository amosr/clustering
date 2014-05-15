module Program.Paper.Fusion
-- (solve_linear
-- ,
-- )
 where

import Graph
import Program.Paper.Base
import Program.Paper.Graph
import Program.Paper.Rate
import Program.Paper.Pretty
--import Linear.Pretty
import Graph.Clusters (invertMap)

import qualified Data.List as List
import qualified Data.Map  as Map
import           Data.Map    (Map)

import Control.Monad.LPMonad
import Data.LinearProgram
--import Data.LinearProgram.GLPK

import System.IO.Unsafe (unsafePerformIO)
import Debug.Trace

--
-- | Variable type for linear program
-- Pi i             - {0..} used to show the resulting partition is acyclic:
--
--      A graph is acyclic iff there is a mapping
--          pi : Node -> Int
--      such that \forall (i,j) \in Edge
--          pi(j) > pi(i)
--
-- SameCluster i j  - {0,1} 0 if i and j are fused together
data GVar
 = Pi Name
 | SameCluster Name Name
 deriving (Eq, Show, Ord)
mkSameCluster :: Name -> Name -> GVar
mkSameCluster m n
 = SameCluster (min m n) (max m n)

-- | Minimise objective:
-- \Sigma_i,j Weight(i,j) * SameCluster(i,j)
gobjective :: [(Int,Name,Name)] -> LinFunc GVar Int
gobjective ws
 =  linCombination
 $  map (\(w,i,j) -> (w, mkSameCluster i j)) ws


-- | Set variable types - Pi are integers, SameCluster are bools
setKinds :: [Name] -> [(Int,Name,Name)] -> LPM GVar Int ()
setKinds ns ws
 = do   mapM_ setP ns
        mapM_ setW ws
 where
  setP n
   = do varGeq     (Pi n) 0
        setVarKind (Pi n) ContVar
  setW (_,i,j)
   = do -- varGeq     (SameCluster i j) 0
        setVarKind (mkSameCluster i j) BinVar


-- | Create constraints for edges and weights
addConstraints :: Int -> Graph'
               -> [((Name,Name),Bool)]
               -> [(Int,Name,Name)]
               -> Program
               -> TransducerMap
               -> LPM GVar Int ()
addConstraints bigN g arcs ws _p trans
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
   | fusible && u `cmp` v
   = do let pis = var (Pi v) ^-^ var (Pi u)
        let x   = var (mkSameCluster u v)
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
        let x   = var (mkSameCluster u v)
        leq ((-bigN) *^ x) pis
        leq pis  (bigN *^ x)
        checkTypes u v

  -- If two types are comparable, but not exactly the same,
  -- we may only fuse them together if their generators are fused together
  checkTypes u v
   | Just uT <- nodeAttribute g u
   , Just vT <- nodeAttribute g v
   , u `cmp` v
   , uT /= vT
   , Just (u',v') <- checkTy' u v
   = do leq' ("Type:" ++ show u ++ ":" ++ show v ++ ":" ++ show u') (var $ mkSameCluster v' v) (var $ mkSameCluster u v)
        leq' ("Type:" ++ show u ++ ":" ++ show v ++ ":" ++ show v') (var $ mkSameCluster u' u) (var $ mkSameCluster u v)
        leq' ("Type:" ++ show u ++ ":" ++ show v) (var $ mkSameCluster u' v') (var $ mkSameCluster u v)
   | otherwise
   = return ()

  -- Ascend in both directions, until equal types are found.
  checkTy' u v
   | Just uT <- nodeAttribute g u
   , Just vT <- nodeAttribute g v
   , uT == vT
   = Just (u,v)
   | NAId u'  <- u
   , Just u'' <- trans (Left u')
   , Just r   <- checkTy' (NAId u'') v
   = Just r
   | NAId v'  <- v
   , Just v'' <- trans (Left v')
   , Just r   <- checkTy' u (NAId v'')
   = Just r
   | NSId u'  <- u
   , Just u'' <- trans (Right u')
   , Just r   <- checkTy' (NAId u'') v
   = Just r
   | NSId v'  <- v
   , Just v'' <- trans (Right v')
   , Just r   <- checkTy' u (NAId v'')
   = Just r
   | otherwise
   = Nothing

  cmp = typeComparable g trans


typeComparable :: Graph' -> TransducerMap -> Name -> Name -> Bool
typeComparable g trans a b
 = case (nodeAttribute g a, nodeAttribute g b) of
   -- Externals can't be fused together, so have different types
--   (Just (Just a'), Just (Just b'))
   (Just a', Just b')
    -> if   a' == b'
       then True
       else try a b || try b a
   _
    -> False
 where
  try (NAId x) y
   | Just x' <- trans (Left x)
   = typeComparable g trans (NAId x') y
   | otherwise
   = False
  try (NSId x) y
   | Just x' <- trans (Right x)
   = typeComparable g trans (NAId x') y
   | otherwise
   = False
  -- externals can't be fused
  try _ _
   = False


-- | Get list of all nodes that might be clustered together,
-- and the weighted benefit of doing so.
clusterings ::  Bool -> [((Name,Name),Bool)] -> [(Name,Maybe Tau)] -> Int -> Graph' -> TransducerMap -> [(Int, Name,Name)]
clusterings simp arcs ns bigN g trans
 = let gs  = go ns
       gs' = filter (\(w,u,v) -> noFusionPreventingPath u v) gs
   in  if simp then gs' else gs
 where
   -- For some node, find all later nodes of same type, and calculate benefit
   go ((u,ty):rest)
    =  filter noweight0
       [ (weight u v ty ty',u,v)
       | (v,ty') <- rest
       --, noFusionPreventingPath u v
       , cmp u v]
    ++ go rest
   go []
    = []

   cmp = typeComparable g trans

   noweight0 (w,_,_) = w > 0

   -- \forall paths p from u to v, fusion preventing \not\in p
   noFusionPreventingPath u v
    -- for all paths, for all nodes in path, is fusible
    = all (all snd) (paths u v)

   -- list of all paths from u to v
   paths u v
    | u == v
    = [[]]
    | otherwise
    = let outs = filter (\((i,_j),_f) -> i == u) arcs
      in  concatMap (\((u',j),f) -> map (((u',j),f):) (paths j v)) outs
   
   -- Simple trick:
   -- if there is an edge between the two,
   --   there will be some cache locality benefit from merging
   -- otherwise, 
   --   the only benefit is reducing loop overhead
   --
   -- Another heuristic would be to count nodes with shared parents as having a locality benefit
   weight u v ty ty'
    -- An edge between them
    | (_:_) <- filter (\((i,j),_) -> (u,v) == (i,j) || (v,u) == (i,j)) arcs
    = bigN * bigN
    -- Share a parent
    | inu <- map (fst.fst) $ filter (\((_,j),_) -> j == u) arcs
    , inv <- map (fst.fst) $ filter (\((_,j),_) -> j == v) arcs
    , shared <- filter (flip elem inu) inv
    -- TODO check that is array
    = bigN * bigN
    | ty == ty'
    = 1
    -- types not exactly same so require complicated constraint; ignore
    | otherwise
    = 1 -- XXX hack, set to 0 to remove non-edge ones
   


-- | Create linear program for graph, and put all the pieces together.
lp :: Program -> Graph' -> TransducerMap -> Bool -> LP GVar Int
lp p g trans simp
 = execLPM
 $ do   setDirection Min
        setObjective $ gobjective weights
        addConstraints numNodes g arcs weights p trans
        setKinds names weights
 where
   g'    = listOfGraph g
   names = map fst $ fst g'
   arcs  =           snd g'

   weights = clusterings simp arcs (fst g') numNodes g trans

   numNodes
     = length names

solve_linear :: Program -> Maybe (Map (Int,Int) [Name])
solve_linear p
 | Just r <- ratesOfProgram p
 , Just g <- graphOfProgram p
 = Just $ solve_linear' p g r

 | otherwise
 = Nothing

solve_linear' :: Program -> Graph' -> (TauMap, TransducerMap) -> Map (Int,Int) [Name]
solve_linear' p g (_,trans)
 -- GLPK has a fit if we give it a problem with no constraints
 | null $ constraints lp'
 = Map.fromList
   [ ((0,n), [k])
   | ((k,_ty),n) <- (fst $ listOfGraph g) `zip` [0..]]

 | otherwise
 = let opts'= mipDefaults { msgLev = MsgOff, brTech = DrTom, btTech = LocBound, cuts = [Cov] }
       res  = unsafePerformIO $ do
                let pre = "lps/lp-" ++ (show $ length $ constraints lp') ++ "-"
                -- writeLP (pre ++ "unopt.lp") lp'unopt
                writeLP (pre ++ "simp.lp") lp'simp
                writeFile (pre ++ "prog.p") (prettyProgram p)
                glpSolveVars opts' $ {-trace (pprLP lp')-} lp'
   in  case res of
        (Success, Just (_, m))
         -> fixMap m -- (trace (show m) m)
        _
         -> error (show res)
 where
  lp'simp  = lp p g trans True
  -- lp'unopt  = lp p g trans False
  lp' = lp'simp

  fixMap m
   = reorder m $ snd $ fill $ Map.foldWithKey go (0, Map.empty) m

  -- TODO: XXX this is wrong;
  -- it relies too much on the order of the variables coming out.
  -- If we had, say,
  -- > Cluster 0 1 = 0
  -- > Cluster 2 3 = 0
  -- > Cluster 0 2 = 0
  -- then 0, 1, 2 and 3 should all clustered together in 0,
  -- but this wrong algo will give 0,1=0 and 2,3=1. damn!
  go k v (n, m)
   | SameCluster i j <- k
   , 0               <- v
   -- , Just ty         <- nodeAttribute g i
   -- , Just ty'        <- nodeAttribute g j
   -- TODO: This should raise an error if it's false
   --, ty `typeComparable` ty'
   = case (Map.lookup i m, Map.lookup j m) of
     (Just iC, Just jC)
      -> if   iC == jC
         then (n, m)
         else (n, Map.map (\x -> if x == iC then jC else x) m)
     (Just iC, Nothing)
      -> (n, Map.insert j iC m)
     (Nothing, Just jC)
      -> (n, Map.insert i jC m)
     (Nothing, Nothing)
      -> ( n + 1
         , Map.insert i n 
         $ Map.insert j n m)

   | otherwise
   = (n, m)

  fill (n, m)
   = foldr goFill (n, m) (fst $ listOfGraph g)

  goFill (k,_ty) (n, m)
   | Map.member k m
   = (n, m)
   | otherwise
   = ( n + 1
     , Map.insert k n m)


  reorder mOrig m
   = Map.fromList
   $ map (reorder' mOrig)
   $ Map.toList $ invertMap m

  reorder' mOrig (k,v:vs)
   | Just k' <- Map.lookup (Pi v) mOrig
   = ((truncate k', k), v:vs)
   | otherwise
   = ((0, k), v:vs)

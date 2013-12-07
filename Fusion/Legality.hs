module Fusion.Legality where

import Graph

import qualified Data.Map as Map
import           Data.Map   (Map)

import Data.Monoid


-- | Check if a partitioning
-- legal :: (Ord k, Eq c) => Graph k na ea -> Map k c -> Bool
-- ...

-- | Check validity of clustering: type constraint.
-- Two verticies of different types cannot belong to the same cluster.
--
-- \forall v,u \in V. T(v) /= T(u) ==> C(v) /= C(u)
typeConstraint :: (Ord k, Eq t, Eq c) => Graph k t e -> Map k c -> Bool
typeConstraint (Graph gmap) c
 = and 
   [ gT u /= gT v || not (gC u /= gC v)
   | u <- Map.keys gmap
   , v <- Map.keys gmap
   ]
 where
  gT k = fst $ gmap Map.! k
  gC k =       c    Map.! k


-- | Check validity of clustering: fusion-preventing constraint.
-- Nodes with fusion-preventing edges between them cannot be in same cluster.
--
-- \forall (u,v) \in Non-Fusible Edges. C(v) >= C(u) + 1
fusionPreventing :: (Ord k, Ord c, Monoid na) => Graph k na Bool -> Map k c -> Bool
fusionPreventing g c
 = let m      = mergeClusters g c
       (_,es) = listOfGraph m
       selfs  = filter (\((i,j),_) -> i == j) es
       -- Search for any False - non-fusible edges
   in  all snd selfs


-- | Check validity of clustering: precedence constraint.
-- The fused graph must be acyclic in order to be a feasible schedule.
-- Self-loops are allowed, however - they do not affect scheduling of clusters.
--
-- \forall (u,v) \in Fusible Edges. C(v) >= C(u)
precedence :: (Ord k, Ord c, Monoid na) => Graph k na Bool -> Map k c -> Bool
precedence g c
 = let m   = mergeClusters g c
       m'  = removeSelfLoops m
   in  not $ isCyclic m'



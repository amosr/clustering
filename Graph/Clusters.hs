module Graph.Clusters
 ( mergeClusters 
 , removeSelfLoops
 ) where

import Graph.Base
import Graph.Order

import qualified Data.Map as Map
import           Data.Map ( Map )

import           Data.List
import           Data.Monoid



-- | Merge graph based on a clustering
-- Merged nodes will take name of first element of cluster by @Ord@.
-- Any nodes not mentioned in @clusters@ are not modified.
--
-- @Ord c@ is required only because it is used as a @Map@ key.
-- @Eq ea@ is used to @nub@ edges, but edges with same @src@ and @dst@ but different annotations are kept.
mergeClusters :: (Ord k, Ord c, Monoid na, Eq ea) => Graph k na ea -> Map k c -> Graph k na ea
mergeClusters graph@(Graph gmap) clusters
 = Graph
 $ foldl go Map.empty
 $ graphTopoOrder graph
 where
  go m node
   -- Merge if it's a weighted one
   | Just k     <- name_maybe node
   = merge node k    m
   | otherwise
   = merge node node m

  merge node k m
   | Just (na, edges) <- Map.lookup node gmap
   = let edges' = nubEdges $ map (\(n,f) -> (name n, f)) edges
     in  Map.insertWith (\(xna,xs) (yna,ys) -> (xna `mappend` yna, nubEdges $ xs ++ ys)) k (na, edges') m
   | otherwise
   = m

  nubEdges = nub 

  weights' = invertMap clusters

  name n
   = maybe n id (name_maybe n)

  name_maybe n
   | Just i      <- Map.lookup n clusters
   , Just (v:_)  <- Map.lookup i weights'
   = Just v
   | otherwise
   = Nothing


-- | Filter out any self-loops from one node to itself
removeSelfLoops :: Ord k => Graph k na ea -> Graph k na ea
removeSelfLoops (Graph gmap)
 = Graph $ Map.mapWithKey kill gmap
 where
  kill k (na, edges)
   = (na, filter ((/=k).fst) edges)


invertMap :: (Ord k, Ord v) => Map.Map k v -> Map.Map v [k]
invertMap m
 = Map.foldWithKey go Map.empty m
 where
  go k v m' = Map.insertWith (++) v [k] m'



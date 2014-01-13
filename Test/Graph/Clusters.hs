module Test.Graph.Clusters (tests) where

import Test.Base

import qualified Data.Map as Map
import           Data.Map  ( Map )
-- import Data.Maybe

tests :: Test
tests = $(testGroupGenerator)

prop_merge_empty_clusters_is_id :: Graph Int () () -> Property
prop_merge_empty_clusters_is_id g
 = let m = merge' g Map.empty
   in  collect m (m == g)

prop_merge_unique_clusters_is_id :: Graph Int () () -> Property
prop_merge_unique_clusters_is_id g@(Graph gmap)
 = let m = merge' g (Map.mapWithKey (\k _ -> k) gmap)
   in  collect m (m == g)


prop_merge_edge :: Graph Int () () -> Property
prop_merge_edge g
 = forAllMaybe (graphEdge g) $ \((i,j),_) ->
   forAllMaybe (graphNode g) $ \k         ->
    let c = Map.fromList [(i,0), (k,0)]
        m = merge' g c
    in  
     (i /= k && k /= j)
    ==> (m `hasNode` i && m `hasEdge` (i,j))
     || (m `hasNode` k && m `hasEdge` (k,j))


prop_merge_only_one_node :: Graph Int () () -> Property
prop_merge_only_one_node g
 = forAllMaybe (graphNode g) $ \i         ->
   forAllMaybe (graphNode g) $ \j         ->
    let c = Map.fromList [(i,0), (j,0)]
        m = merge' g c
    in  (i /= j)
    ==> (m `hasNode` i ==> not $ m `hasNode` j)
    .&. (m `hasNode` j ==> not $ m `hasNode` i)



prop_merge_all_1_node_1_edges :: Graph Int () () -> Property
prop_merge_all_1_node_1_edges g@(Graph gmap)
 = let c = Map.map (const 0) gmap
       m = merge' g c
   in  graphNumNodes m == min 1 (graphNumNodes g)
   .&. graphNumEdges m == min 1 (graphNumEdges g)


merge' :: Graph Int () () -> Map Int Int -> Graph Int () ()
merge' = mergeClusters

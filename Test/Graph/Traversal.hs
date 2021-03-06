module Test.Graph.Traversal (tests) where

import Test.Base

import qualified Data.Map as Map

tests :: Test
tests = $(testGroupGenerator)

-- | Traversal with constant weight of 1 should be less than or equal to number of nodes
prop_traversal_const_1_is_LE_number_nodes :: Graph Int () () -> Bool
prop_traversal_const_1_is_LE_number_nodes g
 = Map.fold max 0 (traversalMax (const 1) g) <= graphNumNodes g

-- | For some edge @(i,j)@, @i@ is earlier in graph traversal so will have lower weight than @j@.
prop_traversal_const_1_edge_implies_src_LT_dst :: Graph Int () () -> Property
prop_traversal_const_1_edge_implies_src_LT_dst graph
 =  forAllMaybe (graphEdge graph) $ \((i,j),_) ->
     trav Map.! i < trav Map.! j
 where
  trav = traversalMax (const 1) graph

-- | Result of traversal should contain all nodes
prop_traversal_contains_all_keys :: Graph Int () () -> Bool
prop_traversal_contains_all_keys g@(Graph gmap)
 = let keys  = Map.keys $ traversalMax (const 1) g
       nodes = Map.keys   gmap
   in  keys == nodes


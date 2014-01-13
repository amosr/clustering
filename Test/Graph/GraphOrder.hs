module Test.Graph.GraphOrder (tests) where

import Test.Base

import Data.Maybe

tests :: Test
tests = $(testGroupGenerator)

-- | Generator should only generate dags with a topo ordering
prop_dag_has_topo_order  :: Graph Int () () -> Bool
prop_dag_has_topo_order  g
 = isJust
 $ graphTopoOrder_maybe g


prop_order_is_valid :: Graph Int () () -> Bool
prop_order_is_valid g
 = isTopoOrder g $ graphTopoOrder g


prop_reverse_order_is_valid_for_flipped_graph :: Graph Int () () -> Bool
prop_reverse_order_is_valid_for_flipped_graph g
 = let g' = reverseGraph   g
   in  isTopoOrder g' $ reverse $ graphTopoOrder g


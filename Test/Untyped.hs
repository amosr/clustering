module Test.Untyped (tests) where

import Test.Base

import Fusion.Untyped
import Fusion.Legality

import Data.Map (Map)

-- import Data.Maybe

tests :: Test
tests = $(testGroupGenerator)

prop_fusion_preventing_constraint :: Graph Int () Bool -> Bool
prop_fusion_preventing_constraint g
 = fusionPreventing g $ traversal_early g

prop_precedence :: Graph Int () Bool -> Bool
prop_precedence g
 = precedence g $ traversal_early g

prop_legal :: Graph Int () Bool -> Bool
prop_legal g
 = legal g $ traversal_early g

prop_latest_legal :: Graph Int () Bool -> Bool
prop_latest_legal g
 = legal g $ traversal_latest g

prop_latest_same_length_as_earliest :: Graph Int () Bool -> Bool
prop_latest_same_length_as_earliest
 = check_same_length traversal_early traversal_latest


prop_traversal_minedges_legal :: Graph Int () Bool -> Bool
prop_traversal_minedges_legal g
 = legal g $ traversal_minedges g


prop_schedule_exists :: Graph Int () Bool -> Bool
prop_schedule_exists g
 = not $ null $ allschedules g

zprop_optimal_legal :: Graph Int () Bool -> Bool
zprop_optimal_legal g
 = legal g $ optimal_minnodes g


prop_optimal_minnodes_same_as_traversal_early :: Graph Int () Bool -> Bool
prop_optimal_minnodes_same_as_traversal_early
 = check_same_length traversal_early optimal_minnodes

prop_optimal_minedges_same_as_traversal_minedges :: Graph Int () Bool -> Property
prop_optimal_minedges_same_as_traversal_minedges g
 = let oe = optimal_minedges g
       tb = traversal_minedges  g

       moe = mergeClusters g oe
       mtb = mergeClusters g tb
   in 
        graphNumNodes moe == graphNumNodes mtb
   .&&. graphNumEdges moe == graphNumEdges mtb


check_same_length :: (Graph Int () Bool -> Map Int Int)
                  -> (Graph Int () Bool -> Map Int Int)
                  -> Graph Int () Bool
                  -> Bool
check_same_length a b g
 = let ca = a g
       cb = b g
       mca = mergeClusters g ca
       mcb = mergeClusters g cb
   in 
        graphNumNodes mca == graphNumNodes mcb



module Test.Fusion.Untyped (tests) where

import Test.Base

import Fusion.Untyped
import Fusion.Legality


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
 = not $ null $ exhaustive_all g

zprop_exhaustive_legal :: Graph Int () Bool -> Bool
zprop_exhaustive_legal g
 = legal g $ exhaustive_minnodes g


prop_exhaustive_minnodes_same_as_traversal_early :: Graph Int () Bool -> Bool
prop_exhaustive_minnodes_same_as_traversal_early
 = check_same_length traversal_early exhaustive_minnodes

prop_exhaustive_minedges_same_as_traversal_minedges :: Graph Int () Bool -> Property
prop_exhaustive_minedges_same_as_traversal_minedges g
 = let oe = exhaustive_minedges g
       tb = traversal_minedges  g

       moe = mergeClusters g oe
       mtb = mergeClusters g tb
   in 
        graphNumNodes moe == graphNumNodes mtb
   .&&. graphNumEdges moe == graphNumEdges mtb

prop_solve_linear_legal :: Graph Int () Bool -> Bool
prop_solve_linear_legal g
 = legal g $ solve_linear g

prop_solve_linear_same_length_as_traversal :: Graph Int () Bool -> Bool
prop_solve_linear_same_length_as_traversal
 = check_same_length solve_linear traversal_early



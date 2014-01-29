module Test.Fusion.Typed (tests) where

import Test.Base

import Fusion.Typed
import Fusion.Legality

-- import Data.Maybe

tests :: Test
tests = $(testGroupGenerator)

prop_ordered_legal :: Graph Int Type Bool -> Bool
prop_ordered_legal g
 = legal g $ ordered_fusion g

prop_exhaustive_exists :: Graph Int Type Bool -> Bool
prop_exhaustive_exists g
 = not $ null $ exhaustive_all g

prop_exhaustive_better_than_ordered :: Graph Int Type Bool -> Bool
prop_exhaustive_better_than_ordered
 = check_leq_length exhaustive_minnodes ordered_fusion

-- TODO
--  check if nodes same, or if fewer nodes only if criss-cross present
--  there's something about *trees* here.

zprop_tree_exhaustive_same_as_ordered :: Graph Int Type Bool -> Property
zprop_tree_exhaustive_same_as_ordered g
 =   isTree g
 ==> check_same_length exhaustive_minnodes ordered_fusion g

zprop_exhaustive_more_possibilities_than_traversal :: Graph Int Type Bool -> Bool
zprop_exhaustive_more_possibilities_than_traversal g
 = length (exhaustive_all g) <= length (traversal_all g)


zprop_exhaustive_same_as_traversal :: Graph Int Type Bool -> Bool
zprop_exhaustive_same_as_traversal
 = check_same_length exhaustive_minnodes traversal_minnodes


zprop_traversal_first_better_than_ordered :: Graph Int Type Bool -> Bool
zprop_traversal_first_better_than_ordered
 = check_leq_length  ordered_fusion (head . traversal_all)

prop_solve_linear_minedges_legal :: Graph Int Type Bool -> Bool
prop_solve_linear_minedges_legal g
 = legal g $ solve_linear_minedges g

zprop_solve_linear_minedges_same_length_as_exhaustive :: Graph Int Type Bool -> Bool
zprop_solve_linear_minedges_same_length_as_exhaustive
 -- = check_same_length solve_linear exhaustive_minnodes
 = check_leq_length solve_linear_minedges ordered_fusion


prop_solve_linear_minnodes_legal :: Graph Int Type Bool -> Bool
prop_solve_linear_minnodes_legal g
 = legal g $ solve_linear_minnodes g


prop_solve_linear_minnodes_same_length_as_exhaustive :: Graph Int Type Bool -> Bool
prop_solve_linear_minnodes_same_length_as_exhaustive
 = check_leq_edges solve_linear_minnodes exhaustive_minedges


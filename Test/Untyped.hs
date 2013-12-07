module Test.Untyped (tests) where

import Test.Base

import Fusion.Untyped
import Fusion.Legality

-- import Data.Maybe

tests :: Test
tests = $(testGroupGenerator)

prop_fusion_preventing_constraint :: Graph Int () Bool -> Bool
prop_fusion_preventing_constraint g
 = fusionPreventing g $ fuse g

prop_precedence :: Graph Int () Bool -> Bool
prop_precedence g
 = precedence g $ fuse g

module Test.Fusion.Typed (tests) where

import Test.Base

import Fusion.Typed
import Fusion.Legality

-- import Data.Maybe

tests :: Test
tests = $(testGroupGenerator)

prop_legal :: Graph Int Type Bool -> Bool
prop_legal g
 = legal g $ ordered_fusion g


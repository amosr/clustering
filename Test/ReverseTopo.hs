module Test.ReverseTopo (tests) where

import Graph.Arbitrary
import Graph.Base

import Test.QuickCheck
import Debug.Trace
import Data.Maybe

import Test.Framework
import Test.Framework.TH

import Test.Framework.Providers.QuickCheck2

tests = $(testGroupGenerator)

-- | Generator should only generate dags with a topo ordering
prop_hasTopoOrder  :: Graph Int () () -> Bool
prop_hasTopoOrder  g
 = isJust
 $ graphTopoOrder g


prop_orderIsValid :: Graph Int () () -> Bool
prop_orderIsValid g
 | Just o <- graphTopoOrder g
 = isTopoOrder g o
 | otherwise
 = error "Not a dag!"


prop_orderReverse :: Graph Int () () -> Bool
prop_orderReverse g
 | Just o' <- graphTopoOrder g
 = let g' = reverseGraph   g
   in  isTopoOrder g' $ reverse o'

 | otherwise
 = error "Not a dag!"


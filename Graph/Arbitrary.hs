module Graph.Arbitrary where

import           Graph.Base

import qualified Data.Map as Map

import           Control.Applicative
import           Test.QuickCheck

instance (Arbitrary k, Integral k, Arbitrary na, Arbitrary ea)
       => Arbitrary (Graph k na ea) where
 arbitrary
  = sized $ \n ->
    do  num     <- choose (0,n)
        let num' = fromIntegral $ num
        Graph  <$> Map.fromList <$> mapM mk [0..num'-1]

  where
   mk i
    = do
        nodeA <- arbitrary
        NonNegative num   <- arbitrary
        let num' = num `mod` (i+1)
        edges <- mapM (mkEdge i) [0..num'-1]
        return (i, (nodeA, edges))

   mkEdge i _n
    = do
        NonNegative num   <- arbitrary
        -- Exclude i from edge list, as it would be a self-loop
        let num' = num `mod` i
        edgeA <- arbitrary
        return (num', edgeA)



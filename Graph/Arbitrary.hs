module Graph.Arbitrary where

import           Graph.Base

import qualified Data.Map as Map

import           Control.Applicative
import           Data.List
import           Test.QuickCheck

instance (Arbitrary k, Integral k, Arbitrary na, Arbitrary ea, Eq ea)
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
        edges <- nub <$> mapM (mkEdge i) [0..num'-1]
        return (i, (nodeA, edges))

   mkEdge i _n
    = do
        NonNegative num   <- arbitrary
        -- Exclude i from edge list, as it would be a self-loop
        let num' = num `mod` i
        edgeA <- arbitrary
        return (num', edgeA)


graphNode :: Ord k => Graph k na ea -> Gen (Maybe k)
graphNode (Graph gmap)
 | Map.null gmap
 = return Nothing
 | otherwise
 = Just <$> (elements $ Map.keys gmap)


graphEdge :: Ord k => Graph k na ea -> Gen (Maybe ((k,k),ea))
graphEdge g@(Graph gmap)
 = do   n <- graphNode g
        case n of
         Nothing
          -> return Nothing
         Just j
          -> do let (_,es) = gmap Map.! j
                if   null es
                then return Nothing
                else elements es >>= \(i,ea) -> return $ Just ((i,j),ea)


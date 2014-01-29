module Test.Base
 ( module Graph
 , module Test.Framework
 , module Test.Framework.TH
 , module Test.Framework.Providers.QuickCheck2
 , module Test.QuickCheck

 , forAllMaybe 
 , check_same_length
 , check_leq_length

 , check_same_edges
 , check_leq_edges
 ) where

import Graph

import Test.Framework
import Test.Framework.TH
import Test.Framework.Providers.QuickCheck2

import Test.QuickCheck

import Data.Map (Map)
import Data.Function (on)


forAllMaybe :: (Show a, Testable prop) => Gen (Maybe a) -> (a -> prop) -> Property
forAllMaybe g f
 =  forAll g $ \e
 -> case e of
     Nothing -> property True
     Just e' -> property $ f e'


check_same_length :: (Ord c, Ord k, Eq ea)
                  => (Graph k na ea -> Map k c)
                  -> (Graph k na ea -> Map k c)
                  -> Graph k na ea
                  -> Bool
check_same_length
 = check_merge2 ((==) `on` graphNumNodes)

check_leq_length  :: (Ord c, Ord k, Eq ea)
                  => (Graph k na ea -> Map k c)
                  -> (Graph k na ea -> Map k c)
                  -> Graph k na ea
                  -> Bool
check_leq_length
 = check_merge2 ((<=) `on` graphNumNodes)

check_same_edges  :: (Ord c, Ord k, Eq ea)
                  => (Graph k na ea -> Map k c)
                  -> (Graph k na ea -> Map k c)
                  -> Graph k na ea
                  -> Bool
check_same_edges
 = check_merge2 ((==) `on` graphNumEdges)


check_leq_edges   :: (Ord c, Ord k, Eq ea)
                  => (Graph k na ea -> Map k c)
                  -> (Graph k na ea -> Map k c)
                  -> Graph k na ea
                  -> Bool
check_leq_edges
 = check_merge2 ((<=) `on` graphNumEdges)



check_merge2      :: (Ord c, Ord k, Eq ea)
                  => (Graph k na ea -> Graph k na ea -> Bool)
                  -> (Graph k na ea -> Map k c)
                  -> (Graph k na ea -> Map k c)
                  -> Graph k na ea
                  -> Bool
check_merge2    p a b g
 = let ca = a g
       cb = b g
       mca = mergeClusters g ca
       mcb = mergeClusters g cb
   in  p mca mcb



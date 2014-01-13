module Fusion.Typed.Base where

import Graph
import           Test.QuickCheck

import qualified Data.Map as Map
import           Data.Map   (Map)

import Data.List (nub)

type Graph' k = Graph k Type Bool

type Clustering k = Map k (Type,Int)

typesOfGraph :: Ord k => Graph' k -> [Type]
typesOfGraph
 = nub
 . map snd
 . fst
 . listOfGraph

restrictClustering :: Ord k => Type -> Graph' k -> Clustering k -> Clustering k
restrictClustering ty g c
 = Map.filterWithKey check c
 where
  check k _
   | Just ty' <- nodeAttribute g k
   = ty == ty'
   | otherwise
   = False

newtype Type = Type Int
 deriving (Eq,Show,Ord)

instance Arbitrary Type where
 arbitrary
  = sized $ \n ->
    do  let n' = sqrt' $ sqrt' n
        num     <- choose (0,n')
        return $ Type num


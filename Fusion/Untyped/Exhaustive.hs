module Fusion.Untyped.Exhaustive where

import Graph
import Fusion.Legality
import Fusion.Untyped.Traversal

import qualified Data.Map as Map
import           Data.Map   (Map)

import           Data.Function (on)
import           Data.List (minimumBy)


exhaustive_minnodes :: Ord k => Graph' k -> Map k Int
exhaustive_minnodes
 = exhaustiveBy graphNumNodes

exhaustive_minedges :: Ord k => Graph' k -> Map k Int
exhaustive_minedges
 = exhaustiveBy graphNumEdges

exhaustiveBy :: Ord k => (Graph' k -> Int) -> Graph' k -> Map k Int
exhaustiveBy f g
 = minimumBy (compare `on` (f . mergeClusters g))
 $ exhaustive_all g

exhaustive_all :: Ord k => Graph' k -> [Map k Int]
exhaustive_all g
 = filter (legal g)
 $ map Map.fromList
 $ gen nodes
 where
  maxn = Map.fold max 0
       $ traversal_early g

  gen (n:ns)
   = [ (n,i) : gs
     | gs <- gen ns
     , i  <- [0..maxn]]
  gen []
   = [[]]

  nodes
   = map fst
   $ fst
   $ listOfGraph g



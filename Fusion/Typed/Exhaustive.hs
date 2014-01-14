module Fusion.Typed.Exhaustive where

import Graph
import Fusion.Typed.Base
import Fusion.Typed.Ordered
import Fusion.Legality

import qualified Data.Map as Map

import           Data.Function (on)
import           Data.List (minimumBy)

exhaustive_minnodes :: Ord k => Graph' k -> Clustering k
exhaustive_minnodes
 = exhaustiveBy graphNumNodes

exhaustive_minedges :: Ord k => Graph' k -> Clustering k
exhaustive_minedges
 = exhaustiveBy graphNumEdges

exhaustiveBy :: Ord k => (Graph' k -> Int) -> Graph' k -> Clustering k
exhaustiveBy f g
 = minimumBy (compare `on` (f . mergeClusters g))
 $ exhaustive_all g

exhaustive_all :: Ord k => Graph' k -> [Clustering k]
exhaustive_all g
 = filter (legal g)
 $ map Map.fromList
 $ gen nodes
 where
  maxn = Map.fold max 0
       $ Map.map snd
       $ ordered_fusion g

  gen ((n,ty):ns)
   = [ (n,(ty,i)) : gs
     | gs <- gen ns
     , i  <- [0..maxn]]
  gen []
   = [[]]

  nodes
   = fst
   $ listOfGraph g


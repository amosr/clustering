module Fusion.Untyped.Traversal where

import Graph
import Fusion.Legality

import qualified Data.Map as Map
import           Data.Map   (Map)

import           Data.Function (on)
import           Data.List (minimumBy)

type Graph' k = Graph k () Bool

delta :: (k,Bool) -> Int
delta (_,f) = if f then 0 else 1

traversal_early :: Ord k => Graph' k -> Map k Int
traversal_early = traversalMax delta

traversal_latest :: Ord k => Graph' k -> Map k Int
traversal_latest g
 = let early  = traversal_early g
       len    = Map.fold max 0 early
       g'     = reverseGraph    g
   in  traversal min len (negate . delta) g'

traversal_minedges :: Ord k => Graph' k -> Map k Int
traversal_minedges = traversal_minBy graphNumEdges

traversal_minBy :: Ord k => (Graph' k -> Int) -> Graph' k -> Map k Int
traversal_minBy f g
 = minimumBy (compare `on` (f . mergeClusters g)) alls
 where
  alls = filter (legal g)
       $ map Map.fromList
       $ gen nodes

  gen ((n,(minn,maxn)):ns)
   = [ (n,i) : gs
     | gs <- gen ns
     , i  <- [minn..maxn]]
  gen []
   = [[]]

  early  = traversal_early  g
  latest = traversal_latest g

  nodes
   = Map.toList
   $ Map.intersectionWith (\a b -> (a,b)) early latest


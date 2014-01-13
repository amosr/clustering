module Fusion.Untyped where

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


optimal_minnodes :: Ord k => Graph' k -> Map k Int
optimal_minnodes
 = optimalBy graphNumNodes

optimal_minedges :: Ord k => Graph' k -> Map k Int
optimal_minedges
 = optimalBy graphNumEdges

optimalBy :: Ord k => (Graph' k -> Int) -> Graph' k -> Map k Int
optimalBy f g
 = minimumBy (compare `on` (f . mergeClusters g))
 $ allschedules g

allschedules :: Ord k => Graph' k -> [Map k Int]
allschedules g
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


module Fusion.Typed.Traversal where

import Graph
import Fusion.Typed.Base
--import Fusion.Typed.Ordered
import Fusion.Legality

import qualified Data.Map as Map
import           Data.Map (Map)

import           Data.Function (on)
import           Data.List (minimumBy)


delta :: (((k,Type),(k,Type)),Bool) -> Int
delta (((_,t1),(_,t2)),f)
 = if   t1 /= t2 || not f
   then 1
   else 0


typeFixup :: Ord k => Graph' k -> Map k Int -> Map k Int
typeFixup g c
 = Map.mapWithKey fix c
 where
  tys = numtys g
  fix k i
   | Just (Type n) <- nodeAttribute g k
   = (tys * i) + n
   | otherwise
   = error "Result of traversal contains key not in graph. Impossible!"

numtys :: Ord k => Graph' k -> Int
numtys g
 | Type n <- maximum $ map snd $ fst $ listOfGraph g
 = (n+1)
 | otherwise
 = error "no types"

traversal_early :: Ord k => Graph' k -> Map k Int
traversal_early g = traversalMax delta g

traversal_latest :: Ord k => Graph' k -> Map k Int
traversal_latest g
 = let early  = traversal_early g
       len    = Map.fold max 0 early + numtys g - 1
       g'     = reverseGraph    g
   in  traversal min len (negate . delta) g'


traversal_minnodes :: Ord k => Graph' k -> Clustering k
traversal_minnodes = traversal_minBy graphNumNodes

traversal_minBy :: Ord k => (Graph' k -> Int) -> Graph' k -> Clustering k
traversal_minBy f g
 = minimumBy (compare `on` (f . mergeClusters g))
 $ traversal_all g

traversal_all   :: Ord k => Graph' k -> [Clustering k]
traversal_all   g
 = filter (legal g)
 $ map Map.fromList
 $ gen nodes
 where
  gen ((n,(minn,maxn)):ns)
   | Just ty <- nodeAttribute g n
   = [ (n,(ty,i)) : gs
     | gs <- gen ns
     , i  <- [minn..maxn]]
   | otherwise
   = error "Node in clustering does not exist in graph. Impossible!"
  gen []
   = [[]]

  early  = traversal_early  g
  latest = traversal_latest g

  nodes
   = Map.toList
   $ Map.intersectionWith (\a b -> (a,b)) early latest


module Graph.Traversal where

import Graph.Base
import Graph.Order

import qualified Data.Map as Map
import           Data.Map   (Map)


traversal :: Ord k => (Int -> Int -> Int) -> Int -> (((k,k), ea) -> Int) -> Graph k na ea -> Map k Int
traversal join identity weight graph@(Graph gmap)
 = foldl go Map.empty
 $ graphTopoOrder graph
 where
  go m node
   = let (_,pres) = gmap Map.! node

         get (k', ea)
          | Just v <- Map.lookup k' m
          = v + weight ((node, k'), ea)
          | otherwise
          = error "Impossible: dag topological order wrong, or cycles in input"

         w     = foldl join identity
               $ map get
               $ pres

     in  Map.insert node w m


traversalMin :: Ord k => (((k,k), ea) -> Int) -> Graph k na ea -> Map k Int
traversalMin
 = traversal min maxBound

traversalMax :: Ord k => (((k,k), ea) -> Int) -> Graph k na ea -> Map k Int
traversalMax
 = traversal max 0

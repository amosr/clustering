module Graph.Traversal where

import Graph.Base
import Graph.Order

import qualified Data.Map as Map
import           Data.Map   (Map)


traversal :: Ord k => (Int -> Int -> Int) -> Int -> ((((k,na),(k,na)), ea) -> Int) -> Graph k na ea -> Map k Int
traversal join identity weight graph@(Graph gmap)
 = foldl go Map.empty
 $ graphTopoOrder graph
 where
--  graph'@(Graph gmap) = removeSelfLoops graph

  go m node
   = let (nna,pres) = gmap Map.! node

         get (k', ea)
          -- Ignore self-loops
          | k' == node
          = identity
          | Just v        <- Map.lookup k' m
          , Just (nna',_) <- Map.lookup k' gmap
          = v + weight (((k',nna'), (node,nna)), ea)
          | otherwise
          = error "Impossible: dag topological order wrong, or cycles in input"

         w     = foldl join identity
               $ map get
               $ pres

     in  Map.insert node w m


traversalMin :: Ord k => ((((k,na),(k,na)), ea) -> Int) -> Graph k na ea -> Map k Int
traversalMin
 = traversal min maxBound

traversalMax :: Ord k => ((((k,na),(k,na)), ea) -> Int) -> Graph k na ea -> Map k Int
traversalMax
 = traversal max 0

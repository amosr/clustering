module Graph.Traversal where

import Graph.Base

import qualified Data.Map as Map
import           Data.Map   (Map)


traversal :: Graph k na ea -> (((k,k), ea) -> Int) -> Map k Int
traversal graph weight
 | Just o <- graphTopoOrder graph
 = foldl go Map.empty o
 | otherwise
 = Map.empty
 where
  go m node
   = let pres  = mlookup "traversal" graph node

         get e@(u,_)
          | Just v <- Map.lookup u m
          = v + weight e node
          | otherwise
          = 0

         w     = foldl max 0
               $ map get
               $ pres

     in  Map.insert node w m




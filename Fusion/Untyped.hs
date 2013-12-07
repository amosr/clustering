module Fusion.Untyped where

import Graph

import qualified Data.Map as Map
import           Data.Map   (Map)


type Graph' k = Graph k () Bool


fuse :: Ord k => Graph' k -> Map k Int
fuse = traversalMax (\(_, f) -> if f then 0 else 1)

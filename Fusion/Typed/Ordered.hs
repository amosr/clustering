module Fusion.Typed.Ordered where

import Graph
import Fusion.Typed.Base

import qualified Data.Map as Map

ordered_fusion :: Ord k => Graph' k -> Clustering k
ordered_fusion = Map.unions . ordered_fusion_all

ordered_fusion_all :: Ord k => Graph' k -> [Clustering k]
ordered_fusion_all g
 = let tys    = typesOfGraph g
       (cs,_) = foldl go ([],g) tys
   in  cs
 where
  go (cs,g') ty
   = let c   = typedTraversal ty g'
         g'' = mergeClusters  g' c
     in  (c:cs, g'')


delta :: Type -> (((k,Type),(k,Type)),Bool) -> Int
delta ty (((_,t1),(_,t2)),f)
 | t1 == ty
 = if   t2 /= ty || not f
   then 1
   else 0
 | otherwise
 = 0

typedTraversal :: Ord k => Type -> Graph' k -> Clustering k
typedTraversal ty g
 = restrictClustering ty g
 $ Map.map (\w -> (ty,w))
 $ traversalMax (delta ty) g


module Graph.Order where

import Graph.Base

import qualified Data.Map as Map
import qualified Data.Set as Set

import           Control.Applicative
import           Control.Monad



-- | Find topological ordering of DAG
graphTopoOrder :: Ord k => Graph k na ea -> Maybe [k]
graphTopoOrder (Graph graph)
 = reverse <$> go (Just ([], Map.keysSet graph, Set.empty))
 where
  go Nothing
   = Nothing
  go (Just (l, unvisited, visiting))
   = case Set.minView unvisited of
     Nothing
      -> Just l
     Just (m, _)
      -> go (visit (l,unvisited,visiting) m)

  visit (l,unvisited, visiting) m
   -- Check for loops
   | True              <- Set.member m visiting
   = Nothing

   -- If we haven't added this to the list yet
   | True              <- Set.member m unvisited
   , Just (_an, edges) <- Map.lookup m graph
   = let pres           = map fst edges
         s'             = Set.delete m unvisited
         visiting'      = Set.insert m visiting
     in do  (l',s'', _)<- foldM visit (l,s',visiting') pres
            return (m:l', s'', visiting)

   -- Already visited and added to the list
   | otherwise
   = return (l, unvisited, visiting)


isTopoOrder :: Ord k => Graph k na ne -> [k] -> Bool
isTopoOrder (Graph g) order
 = maybe False (\s -> Set.size s == Map.size g)
 $ foldM check Set.empty order
 where
  check s o
   | Just (_,ks) <- Map.lookup o g
   , all (flip Set.member s) (map fst ks)
   = Just
   $ Set.insert o s

   -- node not in graph, or node hasn't already been visited
   | otherwise
   = Nothing


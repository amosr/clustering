module Graph.Order where

import Graph.Base

import qualified Data.Map as Map
import qualified Data.Set as Set

import           Control.Applicative
import           Control.Monad



-- | Find topological ordering of DAG.
-- Assume it's a dag - otherwise ERROR!!!
graphTopoOrder :: Ord k => Graph k na ea -> [k]
graphTopoOrder g
 | Just o <- graphTopoOrder_maybe g
 = o
 | otherwise
 = error "Graph not dag!"

-- | Find topological ordering of DAG, or return Nothing if cycles found
graphTopoOrder_maybe :: Ord k => Graph k na ea -> Maybe [k]
graphTopoOrder_maybe (Graph graph)
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
   = let pres           = filter (/= m) -- Knock out self loops
                        $ map fst edges
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


-- | Check if there are cycles in the graph.
isCyclic :: Ord k => Graph k na ea -> Bool
isCyclic g
 = maybe True (const False)
 $ graphTopoOrder_maybe g


-- | Check if dag is roughly tree-like.
-- Assumes it's a DAG.
--
-- Start with empty set.
-- Go through dag in topological order, checking if any edges point to members of set.
-- If edges are in set, that means they already have a parent - and not a tree.
-- If edges aren't in set, add them to set as we have found their parent.
-- Since we're going through in topological order, we don't have to worry about the current node.
isTree :: Ord k => Graph k na ea -> Bool
isTree g
 = maybe False (const True)
 $ foldM check Set.empty
 $ graphTopoOrder g
 where
  Graph rev = reverseGraph g
  check s o
   | Just (_,ks) <- Map.lookup o rev
   , all (not . flip Set.member s) (map fst ks)
   = Just
   $ foldl (flip Set.insert) s (map fst ks)

   | otherwise
   = Nothing

module Graph.Base where

import qualified Data.Map as Map
import           Data.Map   (Map)

import qualified Data.Set as Set
import           Data.Set   (Set)


import           Control.Applicative
import           Control.Arrow
import           Control.Monad
import           Data.Maybe
import           Data.Tuple

newtype Graph k na ea
 = Graph (Map k (na, [(k, ea)]))
 deriving (Show)

type Simple
 = Graph Int () ()


graphNumNodes (Graph g)
 = Map.size g

-- | Reverse a graph, flipping its edges
reverseGraph :: Ord k => Graph k na ea -> Graph k na ea
reverseGraph g
 = graphOfList
 $ second (map (first swap))
 $ listOfGraph g


listOfGraph :: Ord k => Graph k na ea -> ([(k,na)], [((k,k),ea)])
listOfGraph (Graph g)
 = (nodes, edges)
 where
  gl = Map.toList g

  nodes = map       (\(k,(na,_)) -> (k,na)) gl
  edges = concatMap (\(k,(_,es)) -> map (\(k',ea) -> ((k,k'),ea)) es) gl


graphOfList :: Ord k => ([(k,na)], [((k,k),ea)]) -> Graph k na ea 
graphOfList (nodes, edges)
 = Graph
 $ addEdges nodeMap
 where
  nodeMap
   = Map.fromList
   $ map (\(k,na) -> (k,(na,[])))
   $ nodes

  addEdges g
   = foldl insE g edges

  insE g ((k,k'),ea)
   = Map.adjust (\(na,es) -> (na, (k',ea):es))
     k g


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

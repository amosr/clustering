module Graph.Base where

import qualified Data.Map as Map
import           Data.Map   (Map)

import           Control.Arrow
import           Data.Tuple

newtype Graph k na ea
 = Graph (Map k (na, [(k, ea)]))
 deriving (Show,Read,Eq)

type Simple
 = Graph Int () ()


-- | Number of nodes in graph
graphNumNodes :: Graph k na ea -> Int
graphNumNodes (Graph g)
 = Map.size g

-- | Total number of edges in graph
graphNumEdges :: Graph k na ea -> Int
graphNumEdges (Graph g)
 = Map.fold (+)            0
 $ Map.map  (length . snd) g


hasNode :: Ord k => Graph k na ea -> k -> Bool
hasNode (Graph gmap) k
 = k `Map.member` gmap

hasEdge :: Ord k => Graph k na ea -> (k,k) -> Bool
hasEdge g (i,j)
 = i `elem` nodeInputs g j

nodeInputs :: Ord k => Graph k na ea -> k -> [k]
nodeInputs g k
 = map fst
 $ nodeInEdges g k

nodeInEdges :: Ord k => Graph k na ea -> k -> [(k,ea)]
nodeInEdges (Graph gmap) k
 | Just (_,es) <- Map.lookup k gmap
 = es
 | otherwise
 = []

-- TODO nodeOutputs, nodeOutEdges

-- | Convert @Graph@ to a lists of nodes and a list of edges
listOfGraph :: Ord k => Graph k na ea -> ([(k,na)], [((k,k),ea)])
listOfGraph (Graph g)
 = (nodes, edges)
 where
  gl = Map.toList g

  nodes = map       (\(k,(na,_)) -> (k,na)) gl
  edges = concatMap (\(k,(_,es)) -> map (\(k',ea) -> ((k,k'),ea)) es) gl


-- | Convert lists of nodes and list of edges to a @Graph@
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


-- | Reverse a graph, flipping its edges
reverseGraph :: Ord k => Graph k na ea -> Graph k na ea
reverseGraph g
 = graphOfList
 $ second (map (first swap))
 $ listOfGraph g


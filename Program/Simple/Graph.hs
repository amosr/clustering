module Program.Simple.Graph
 ( graphOfProgram
 , Graph'
 , Name
 ) where

import Program.Simple.Base
import Program.Simple.Rate
import Graph

import qualified Data.Map as Map
import           Data.Map   (Map)


data Name  
 = NAId AId
 | NSId SId
 | NOut
 deriving (Eq,Ord,Show)
type Graph' = Graph Name Rate Bool


graphOfProgram :: Program -> Maybe Graph'
graphOfProgram p
 | Just r <- ratesOfProgram p
 = Just 
 $ graphOfList
 $ mkGraph p r

 | otherwise
 = Nothing


mkGraph :: Program -> Map AId Rate -> ([(Name,Rate)], [((Name,Name), Bool)])
mkGraph p r
 = (nodes, edges)
 where
  binds
   = _pBinds p

  nodes
   = concatMap getNode binds 
   ++ [(NOut, Rate [])]
  
  getNode (ABind aid _)
   = [(NAId  aid, r Map.! aid)]
  getNode (SBind sid (Reduce _ aid))
   = [(NSId  sid, r Map.! aid)]

  edges
   = concatMap getEdges binds

  getEdges (ABind aid x)
   = case x of
      MapN f ins
       ->  funEdges (NAId aid) f
       ++ map (\inx -> ((NAId aid, NAId inx), edge_fusible)) ins
      Filter f in1
       ->  funEdges (NAId aid) f
       ++ [((NAId aid, NAId in1), edge_fusible)]
      -- bpermute requires random access to its data
      -- but can read its indices sequentially
      BPermute indata indices
       -> [ ((NAId aid, NAId indata),  edge_blocking)
          , ((NAId aid, NAId indices), edge_fusible)]

  getEdges (SBind sid (Reduce f aid))
   =   funEdges (NSId sid) f
   ++ [((NSId sid, NAId aid), edge_fusible)]

  -- Because the only way to create an SId is with a reduce, and output of reduce is non-fusible, all these edges must be non-fusible.
  funEdges nm (Fun ls)
   = map (\sid -> ((nm, NSId sid), edge_blocking)) ls

  edge_blocking = False
  edge_fusible  = True


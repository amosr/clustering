module Program.Paper.Graph
 ( graphOfProgram
 , Graph'
 , Name(..)
 ) where

import Program.Paper.Base
import Program.Paper.Rate
import Graph

import qualified Data.Map as Map
import           Data.Map   (Map)


data Name  
 = NAId AId
 | NSId SId
 | NExt [AId] [SId]
-- | NOut
 deriving (Eq,Ord,Show)

type Graph' = Graph Name (Maybe Tau) Bool


graphOfProgram :: Program -> Maybe Graph'
graphOfProgram p
 | Just r <- ratesOfProgram p
 = Just 
 $ graphOfList
 $ mkGraph p r

 | otherwise
 = Nothing


mkGraph :: Program -> (TauMap, TransducerMap) -> ([(Name,Maybe Tau)], [((Name,Name), Bool)])
mkGraph p (tau, _trans)
 = (nodes, edges)
 where
  binds
   = _pBinds p

  _inputs
   = _pInputs p
  _outputs
   = _pOutputs p

  nodes
  -- =  map getIn (fst inputs)
   =  map getNode binds 
   -- ++ [(NOut, Rate [])]

  getNode (ABind aid _)
   = (NAId  aid, tau aid)
  getNode (SBind sid (Reduce _ aid))
   = (NSId  sid, tau aid)
  getNode (External (outA,outS) _)
   = (NExt outA outS, Nothing)

  edges
   =  concatMap getEdges binds
  -- ++ map getOutEdge (fst outputs)

  getEdges (ABind aid x)
   = case x of
      MapN f ins
       ->  funEdges (NAId aid) f
       ++ map (\inx -> inedge (NAId aid) inx edge_fusible) ins
      Filter f in1
       ->  funEdges (NAId aid) f
       ++ [inedge (NAId aid) in1 edge_fusible]
      -- bpermute requires random access to its data
      -- but can read its indices sequentially
      BPermute indata indices
       -> [ inedge (NAId aid) indata  edge_blocking
          , inedge (NAId aid) indices edge_fusible ]

      Generate s (Fun ls)
       -> funEdges (NAId aid) (Fun (s : ls))

      -- Cross product must read first array many times
      Cross ina inb
       -> [ inedge (NAId aid) ina edge_blocking
          , inedge (NAId aid) inb edge_fusible ]

  getEdges (SBind sid (Reduce f aid))
   =   funEdges (NSId sid) f
   ++ [inedge (NSId sid) aid edge_fusible]

  getEdges (External (outA,outS) (inA,inS))
   = let from = NExt outA outS
     in  funEdges from (Fun inS)
     ++  map (\a -> inedge from a edge_blocking) inA

  inedge from to fusible
   = case extOfA binds to of
     Just (inA,inS)
      -> ((from, NExt inA inS), edge_blocking)
     _
      -> ((from, NAId to),      fusible)

  -- Because the only way to create an SId is with a reduce, and output of reduce is non-fusible, all these edges must be non-fusible.
  funEdges nm (Fun ls)
   = map (\sid ->
            case extOfS binds sid of
            Just (inA,inS)
             -> ((nm, NExt inA inS), edge_blocking)
            Nothing
             -> ((nm, NSId sid), edge_blocking)) ls

  -- All outputs must be made manifest, ie no fusion is possible
  --getOutEdge aid
  -- = ((NAId aid, NOut), edge_blocking)

  edge_blocking = False
  edge_fusible  = True


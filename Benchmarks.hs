import Common.Pretty
import Program.Paper.Base
import Program.Paper.Fusion
import Program.Paper.Graph
import Program.Paper.Parser
import Program.Paper.Rate

import Graph.Clusters (invertMap)

import qualified Data.Map as Map
import           Data.Map ( Map )

import System.Environment


main
 = do   args <- getArgs
        case args of
         [file] -> go file
         _ -> error "Usage: bench <file>"

 where
  go file
   = do str <- readFile file
        case parse str of
         Left err
          -> print err
         Right pr
          -> do -- print pr
                let solved = solve_linear $ _prProgram pr
                case solved of
                 Nothing
                  -> error "Could not solve?"
                 Just solved'
                  -> do let strs = stringify pr $ invertMap solved'
                        mapM_ (putStrLn . showCluster) strs
                        -- print $ invertMap solved'
                        -- print $ graphOfProgram $ _prProgram pr

stringify :: ParseResult -> Map Int [Name] -> [[String]]
stringify pr sol
 = map (map str)
 $ Map.elems sol
 where
  str (NAId n)
   = na n
  str (NSId n)
   = ns n
  str (NExt as ss)
   = "External(" ++ concatMap na as ++ concatMap ns ss ++ ")"

  na n
   = maybe "Unknown" id
   $ lookup n (_prANames pr)

  ns n
   = maybe "Unknown" id
   $ lookup n (_prSNames pr)

showCluster :: [String] -> String
showCluster ss = "{ " ++ (concatMap (++ " ") ss) ++ "}"


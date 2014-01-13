module Main where

import Test.Framework
import qualified Test.Graph.GraphOrder as TG_Order
import qualified Test.Graph.Traversal  as TG_Traversal
import qualified Test.Graph.Clusters   as TG_Clusters

import qualified Test.Fusion.Untyped   as TF_Untyped
import qualified Test.Fusion.Typed     as TF_Typed

import System.Environment (getArgs)


all_tests :: [Test]
all_tests
 = [ TG_Order.tests
   , TG_Traversal.tests
   , TG_Clusters.tests
   , TF_Untyped.tests
   , TF_Typed.tests
   ]

main :: IO ()
main = do
    args <- getArgs
    let args' = ["--maximum-generated-tests", "100"] ++ args
    defaultMainWithArgs all_tests args'

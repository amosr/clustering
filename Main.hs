module Main where

import Test.Framework
import qualified Test.GraphOrder as T_Order
import qualified Test.Traversal  as T_Traversal

import System.Environment (getArgs)


all_tests :: [Test]
all_tests
 = [ T_Order.tests
   , T_Traversal.tests ]

main :: IO ()
main = do
    args <- getArgs
    let args' = ["--maximum-generated-tests", "100"] ++ args
    defaultMainWithArgs all_tests args'

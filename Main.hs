module Main where

import Test.Framework
import qualified Test.ReverseTopo as T_RT

import System.Environment (getArgs)


all_tests
 = [ T_RT.tests ]

main = do
    args <- getArgs
    let args' = ["--maximum-generated-tests", "1000"] ++ args
    defaultMainWithArgs all_tests args'

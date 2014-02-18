module Test.Program.Simple (tests) where

import Test.Base

import Program.Simple
import Debug.Trace

tests :: Test
tests = $(testGroupGenerator)

zprop_show :: Program -> Bool
zprop_show p
 = trace (prettyProgram p) True

prop_show_graph :: Program -> Bool
prop_show_graph p
 = case graphOfProgram p of
   Nothing 
    -> trace (prettyProgram p ++ "^^^ couldn't do it ^^^") True
   Just g 
    -> trace (prettyProgram p ++ "^^^ converted to...\n" ++ show g) True

zprop_show_rates :: Program -> Bool
zprop_show_rates p
 = case ratesOfProgram p of
   Nothing 
    -> trace (prettyProgram p ++ "^^^ couldn't do it ^^^") True
   Just g 
    -> trace (prettyProgram p ++ "^^^ converted to...\n" ++ show g) True

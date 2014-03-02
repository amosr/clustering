module Test.Program.Simple (tests) where

import Test.Base

import Fusion.Legality
import Program.Simple
import Program.Simple.Fusion
import Debug.Trace

import qualified Data.Map as Map


tests :: Test
tests = $(testGroupGenerator)

zprop_show :: Program -> Bool
zprop_show p
 = trace (prettyProgram p) True

prop_graph_acyclic :: ValidProgram -> Bool
prop_graph_acyclic (ValidProgram _p g)
 = not $ isCyclic g

prop_legalish :: ValidProgram -> Bool
prop_legalish (ValidProgram p g)
 = case solve_linear p of
   Nothing
    -> error "What?"
   Just c
    -> trace (prettyProgram p)
     $ precedence g c && fusionPreventing g c


ztest_specific :: (Bool, [(Name, Int)])
ztest_specific
 = (sol == Map.fromList
    [ (NAId filt,  0)
    , (NSId s1,    0)
    , (NSId s2,    0)
    , (NAId filt', 1)
    , (NAId as',   2)
    ]
 , Map.toList sol)

 where
  Just sol
   = solve_linear ztest_prog

ztest_prog :: Program
ztest_prog
 = prog
 where
  prog
   = Program
   { _pInputs  = ([as], [])
   , _pBinds   = binds
   , _pOutputs = ([as', filt'], []) }

  binds
   = [ ABind filt  $ Filter (Fun [])    as
     , SBind s1    $ Reduce (Fun [])    filt
     , SBind s2    $ Reduce (Fun [])    as
     , ABind filt' $ MapN   (Fun [s1]) [filt]
     , ABind as'   $ MapN   (Fun [s2]) [as]
     ]

as :: AId
as    = AId 0
filt :: AId
filt  = AId 1
as' :: AId
as'   = AId 2
filt' :: AId
filt' = AId 3

s1 :: SId
s1    = SId 0
s2 :: SId
s2    = SId 1


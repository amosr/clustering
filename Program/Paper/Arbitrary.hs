module Program.Paper.Arbitrary where

import Graph
import Program.Paper.Base
import Program.Paper.Graph
import Program.Paper.Pretty
import Test.QuickCheck

import Control.Applicative
import Data.Maybe

data ValidProgram
 = ValidProgram Program Graph'
 deriving (Eq)
instance Show ValidProgram where
 show (ValidProgram p _g)
  = prettyProgram p

instance Arbitrary ValidProgram where
 arbitrary
  = do
        p <- arbitrary `suchThat` (isJust . graphOfProgram)
        case graphOfProgram p of
         Nothing -> error "IMPOSSIBLE arbitrary ValidProgram"
         Just g  -> return $ ValidProgram p g


 

instance Arbitrary Program where
 arbitrary
  = sized $ \n ->
    do  let n' = sqrt' n
        inAs      <- choose (0,n')
        inSs      <- choose (0,n')
            -- Because there are no array generation stmts,
            -- we need at least one array
        let inAIds = map AId [0..inAs]
            inSIds = map SId [0..inSs]
            scope  = Scope inAIds inSIds (inAs+1) (inSs+1)
        nbinds    <- choose (0,n)
        binds     <- go nbinds scope
        return $ Program (inAIds, inSIds) binds (outputsOfBinds (inAIds, inSIds) binds)
        
   where
    go 0 _
     = return []
    go n scope
     = do  
        (bind,scope') <- mkBind scope

        rest <- go (n-1) scope'
        return (bind : rest)
    mkBind scope
     = elements
        [ mkReduce
        , mkMap
        , mkFilter
        , mkPermute
        , mkGenerate
        , mkCross
        , mkExternal
        ] >>= ($ scope)

    mkReduce scope
     = do
        f     <- mkFun    $ _sSIds scope
        in1   <- elements $ _sAIds scope
        return $ mkSBind scope $ Reduce f in1

    mkMap scope
     = do
        f     <- mkFun         $ _sSIds scope
        ins   <- sublist 1 3   $ _sAIds scope
        ins' <- if ins == [] then {- error $ "But...!" ++ show scope -} return $ _sAIds scope else return ins
        return $ mkABind scope $ MapN f ins'

    mkFilter scope
     = do
        f     <- mkFun         $ _sSIds scope
        in1   <- elements      $ _sAIds scope
        return $ mkABind scope $ Filter f in1

    mkPermute scope
     = do
        in1   <- elements      $ _sAIds scope
        in2   <- elements      $ _sAIds scope
        return $ mkABind scope $ BPermute in1 in2

    mkGenerate scope
     = do
        sz    <- elements      $ _sSIds scope
        f     <- mkFun         $ _sSIds scope
        return $ mkABind scope $ Generate sz f

    mkCross scope
     = do
        in1   <- elements      $ _sAIds scope
        in2   <- elements      $ _sAIds scope
        return $ mkABind scope $ Cross in1 in2

    mkExternal scope
     = do
        inA   <- sublist 0 3   $ _sAIds scope
        inS   <- sublist 0 3   $ _sSIds scope
        let a = AId $ _sAIdFresh scope
        let s = SId $ _sSIdFresh scope
        return $
          ( External ([a],[s]) (inA, inS)
          , scope
            { _sAIds = _sAIds scope ++ [a]
            , _sAIdFresh = _sAIdFresh scope + 1
            , _sSIds = _sSIds scope ++ [s]
            , _sSIdFresh = _sSIdFresh scope + 1 })

    mkABind scope x
     = let b = AId $ _sAIdFresh scope
       in  ( ABind b x
           , scope
             { _sAIds = _sAIds scope ++ [b]
             , _sAIdFresh = _sAIdFresh scope + 1 })
    mkSBind scope x
     = let b = SId $ _sSIdFresh scope
       in  ( SBind b x
           , scope
             { _sSIds = _sSIds scope ++ [b]
             , _sSIdFresh = _sSIdFresh scope + 1 })

    mkFun sids
     = Fun <$> sublist 0 5 sids

    sublist from to xs
     = do
        sz <- choose (from, to)
        sublistOfSize sz (length xs) xs
    sublistOfSize _want _lenxs []
     =  return []
    sublistOfSize want lenxs (x:xs)
     = do
        coin <- choose (0,lenxs)
        if   coin < want
        then (x:) <$> sublistOfSize (want-1) (lenxs-1) xs
        else          sublistOfSize  want    (lenxs-1) xs


data Scope
 = Scope
 { _sAIds :: [AId]
 , _sSIds :: [SId]
 , _sAIdFresh :: Int
 , _sSIdFresh :: Int
 }
 deriving (Show)



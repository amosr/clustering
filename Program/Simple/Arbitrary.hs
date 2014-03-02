module Program.Simple.Arbitrary where

import Graph
import Program.Simple.Base
import Program.Simple.Graph
import Test.QuickCheck

import Control.Applicative
import Data.Maybe

data ValidProgram
 = ValidProgram Program Graph'
 deriving (Show,Eq)

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
        return $ mkABind scope $ MapN f ins

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



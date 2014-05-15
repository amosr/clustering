module Program.Paper.Base where

import Data.List ((\\))

-- First order array programs, representation from paper

-- | Array identifiers
newtype AId = AId Int
 deriving (Eq,Show,Ord)

-- | Scalar identifiers
newtype SId = SId Int
 deriving (Eq,Show,Ord)

-- | A program is a list of non-recursive bindings
data Program
 = Program
 { _pInputs  :: ([AId], [SId]) -- ^ parameters. these ids may be referenced in binds
 , _pBinds   ::  [Bind]        -- ^ list of non-recursive sequential bindings
 , _pOutputs :: ([AId], [SId]) -- ^ return values. these ids must be bound in binds (or inputs I guess, but what's the point)
 -- Actually, I don't think this field is necessary.
 -- Certainly not needed for building graph.
 -- Although I guess it means these arrays will definitely be manifest.
 }
 deriving (Show,Eq)

-- | Split bindings into array, scalar and external bindings
data Bind
 -- | array      = abind
 = ABind AId AExp
 -- | scalar     = sbind
 | SBind SId SExp
 -- | scalar..., array... = external scalar..., array...
 | External ([AId], [SId]) ([AId], [SId])
 deriving (Show,Eq)

-- | A worker function can only reference scalars.
-- We don't care what it actually does, only what it touches
newtype Fun
 = Fun [SId]
 deriving (Show,Eq)

data AExp
 = MapN     Fun [AId]
 | Filter   Fun AId
 | BPermute     AId AId
 | Generate SId Fun
 | Cross        AId AId
 deriving (Show,Eq)

data SExp
 = Reduce   Fun AId
 deriving (Show,Eq)


-- | Find all binds that aren't "mentioned".
-- This is really just a helper for generating random programs.
outputsOfBinds :: ([AId],[SId]) -> [Bind] -> ([AId],[SId])
outputsOfBinds ins bs
 = foldl go ins bs
 where
  go (as,ss) b
   = case b of
      ABind aid x
       -> removeAX (as ++ [aid], ss) x
      SBind sid x
       -> removeSX (as, ss ++ [sid]) x
      External (outA,outS) (inA,inS)
       -> ((as \\ inA) ++ outA, (ss \\ inS) ++ outS)

  removeAX (as,ss) x
   = case x of
      MapN   (Fun fs) aids
       -> (as \\ aids, ss \\ fs)
      Filter (Fun fs) aid
       -> (as \\ [aid], ss \\ fs)
      BPermute in1 in2
       -> (as \\ [in1, in2], ss)
      Generate sz (Fun fs)
       -> (as, ss \\ (sz : fs))
      Cross in1 in2
       -> (as \\ [in1, in2], ss)
  removeSX (as,ss) x
   = case x of
      Reduce (Fun fs) aid
       -> (as \\ [aid], ss \\ fs)


-- | Find binder of array. Or else.
bindOfA :: [Bind] -> AId -> Maybe AExp
bindOfA bs a
 = go bs
 where
  go (ABind a' x:bs)
   = if a' == a then Just x else go bs
  go (_:bs)
   = go bs
  go []
   = Nothing

-- | Find binder of array. Or else.
bindOfS :: [Bind] -> SId -> Maybe SExp
bindOfS bs a
 = go bs
 where
  go (SBind a' x:bs)
   = if a' == a then Just x else go bs
  go (_:bs)
   = go bs
  go []
   = Nothing



extOfA :: [Bind] -> AId -> Maybe ([AId],[SId])
extOfA bs a
 = go bs
 where
  go (External (inA,inS) _:bs)
   = if a `elem` inA then Just (inA,inS) else go bs
  go (_:bs)
   = go bs
  go []
   = Nothing

extOfS :: [Bind] -> SId -> Maybe ([AId],[SId])
extOfS bs a
 = go bs
 where
  go (External (inA,inS) _:bs)
   = if a `elem` inS then Just (inA,inS) else go bs
  go (_:bs)
   = go bs
  go []
   = Nothing



module Program.Simple.Base where

import Data.List ((\\))

-- First order array programs!
-- ?

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

-- | Split bindings into array or scalar bindings
data Bind
 = ABind AId AExp
 | SBind SId SExp
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
 deriving (Show,Eq)

data SExp
 = Reduce   Fun AId
 deriving (Show,Eq)


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

  removeAX (as,ss) x
   = case x of
      MapN   (Fun fs) aids
       -> (as \\ aids, ss \\ fs)
      Filter (Fun fs) aid
       -> (as \\ [aid], ss \\ fs)
      BPermute in1 in2
       -> (as \\ [in1, in2], ss)
  removeSX (as,ss) x
   = case x of
      Reduce (Fun fs) aid
       -> (as \\ [aid], ss \\ fs)

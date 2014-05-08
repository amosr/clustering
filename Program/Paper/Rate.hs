module Program.Paper.Rate where

import Program.Paper.Base
import qualified Data.Map as Map
import           Data.Map   (Map)
import qualified Data.Set as Set
import           Data.Set   (Set)

import Control.Arrow
import Control.Monad

data Klok = Klok AId
          | KlokMod AId String
    deriving (Eq,Ord,Show)

-- tau ::= k         (size variable)
--       | tau * tau (cross product)
data Tau = TK Klok
         | TCross Tau Tau
    deriving (Show)


-- We require an interesting definition of Ord and Eq,
-- because cross product is commutative
normalTau :: Tau -> Tau
normalTau (TK k) = TK k
normalTau (TCross a b)
 = let a' = normalTau a
       b' = normalTau b
   in TCross (min a' b') (max a' b')

instance Ord Tau where
 compare (TK a) (TK b)
   = compare a b

 compare (TCross a b) (TCross c d)
   = compare (min a b, max a b) (min c d, max c d)

 compare (TK _) (TCross _ _)
   = LT
 compare (TCross _ _) (TK _)
   = GT

instance Eq Tau where
 (==) (TK a) (TK b)
  = a == b
 (==) (TCross a b) (TCross c d)
  = (min a b, max a b) == (min c d, max c d)
 (==) _ _
  = False


-- C   ::= true         (trivially true)
--       | array = tau  (equality constraint)
--       | C /\ C       (conjunction)
data C  = CTrue
        | CEqual AId Tau
        | CAnd   C   C
    deriving (Show)

cAnds :: [C] -> C
cAnds []     = CTrue
cAnds (c:cs) = foldr CAnd c cs

cEqs :: [AId] -> Klok -> C
cEqs as k
 = cAnds (map (flip CEqual (TK k)) as)

cEq  ::  AId  -> Klok -> C
cEq  a k
 = CEqual a (TK k)


-- Gamma ::= ... zs : k | k | \exists k
data KlokGamma
 = KArray AId
 | KUnification Klok
 | KSkolem      Klok
    deriving (Eq,Ord,Show)

kUnif :: AId -> KlokGamma
kUnif = KUnification . Klok
kRigid :: AId -> KlokGamma
kRigid = KSkolem . Klok

-- Gamma ::= . | Gamma, Gamma | zs : k | k | \exists k
type Gamma = [KlokGamma]


constraintBind :: Gamma -> Bind -> (Gamma, C)
constraintBind g b
 = case b of
   ABind zs (MapN _ as)
    -> ( g ++ [KArray zs, kUnif zs]
       , (cEq zs (Klok zs)) `CAnd` cEqs as (Klok zs))

   ABind zs (Filter _ _)
    -> ( g ++ [KArray zs, kRigid zs]
       , cEq zs (Klok zs))

   ABind zs (Generate _ _)
    -> ( g ++ [KArray zs, kRigid zs]
       , cEq zs (Klok zs))

   ABind zs (BPermute _xs is)
    -> ( g ++ [KArray zs, kUnif zs]
       , cAnds [cEq zs (Klok zs), cEq is (Klok zs)])

   ABind zs (Cross xs ys)
    -> let k'  = KlokMod zs "1"
           k'' = KlokMod zs "2"
    in ( g ++ [KArray zs,  KUnification k', KUnification k'']
       , cAnds [ CEqual zs (TCross (TK k') (TK k''))
               , cEq xs k'
               , cEq ys k''])

   SBind _zs (Reduce _ _)
    -> ( g
       , CTrue)
   External (outA,_) (_, _)
    -> ( g ++ concatMap (\a -> [KArray a, kRigid a]) outA
       , cAnds $ map (\a -> cEq a (Klok a)) outA)


constraintBinds :: Gamma -> [Bind] -> (Gamma, C)
constraintBinds g []
 = (g, CTrue)
constraintBinds g (b:bs)
 = let (g',  c)  = constraintBind  g  b
       (g'', c') = constraintBinds g' bs
   in  (g'', c `CAnd` c')

constraintProgram :: Program -> (Gamma, C)
constraintProgram p
 = let g = map KArray $ fst $ _pInputs p
   in  constraintBinds g $ _pBinds p


-- | Check if constraints are valid
-- TODO
valid :: (Gamma,C) -> Bool
valid _ = True


type EquivClass    = [Set AId]


-- | Get equivalence class of array names in constraints
-- Assuming that it's valid
closure :: C -> EquivClass
closure c
 = let alls     = gen c
       squashed = squash alls []
   in  map cull squashed
 where
  -- Generate a separate set from each constraint
  gen CTrue
   = []
  gen (CEqual aid ka)
   = [Set.fromList [Left aid, Right ka]]
  gen (CAnd l r)
   = gen l ++ gen r


  -- Squash constraint sets together
  squash []     acc
   = acc
  squash (a:as) acc
   -- Try to merge the @a@ set into @acc@ somewhere
   -- If so, start merging the whole thing again
   | Just merged <- squash_merge a acc
   = squash (merged ++ as) []
   -- Nothing in @a@ is mentioned in @acc@, so no merging required:
   --   just add this set to the accumulator
   | otherwise
   = squash as (a:acc)

  squash_merge ins (s:ss)
   -- Check if any members of @ins@ are mentioned in @s@
   -- If so, merge them into one equivalence class
   | not $ Set.null $ ins `Set.intersection` s
   = Just (ins `Set.union` s : ss)
   -- Check if there is a chance to merge later
   | Just ss' <- squash_merge ins ss
   = Just (s : ss')
  -- No merge is possible
  squash_merge _ins _ss
   = Nothing


  -- | Filter out the intermediate / unification variables
  cull ss
   = Set.fromList
   $ concatMap cull'
   $ Set.toList ss

  cull' (Left i)
   = [i]
  cull' (Right _)
   = []



-- | Get canonical name for given equivalence class
-- Return original if there is none
-- (for example, a filter with no maps applied would have none since equiv classes are only built from maps)
canonName :: EquivClass -> AId -> AId
canonName equivs n
 = case equivSet equivs n of
    Nothing -> n
    Just s  -> Set.findMin s


-- | Get set of associated names in given equivalence class
equivSet :: EquivClass -> AId -> Maybe (Set AId)
equivSet equivs n = go equivs
 where
  -- No classes left, not found
  go []
   = Nothing

  -- If @n@ is a member of this class, return it
  go (c:cs')
   | Set.member n c
   = Just c

   -- Check the rest 
   | otherwise
   = go cs'



type TransducerMap = AId -> Maybe AId
type TauMap        = AId -> Maybe Tau

transducers :: [Bind] -> TransducerMap
transducers bs n
 = case bindOfA bs n of
   Just (Filter _ a)
    -> trans' a
   _
    -> trans' n
 where
  trans' n
   = case bindOfA bs n of
    Just (Filter _ a)
     -> Just n
    -- See uniqueness transducer
    Just (MapN _ as)
     -> foldl plus_maybe Nothing
      $ map trans' as
    Just (Generate _ _)
     -> Nothing
    Just (BPermute _ _)
     -> Nothing
    Just (Cross _ _)
     -> Nothing
    Nothing
     -> Nothing


  plus_maybe (Just a) _ = Just a
  plus_maybe Nothing  b = b


taus        :: [Bind] -> EquivClass -> TauMap
taus bs eqs n
 = case bindOfA bs n of
   Just (Filter _ a)
    -> Just (canon a)
   _
    -> Just (canon n)
   --Nothing -- External
   -- -> Nothing

 where
  canon = TK . Klok . canonName eqs




ratesOfProgram :: Program -> Maybe (TauMap, TransducerMap)
ratesOfProgram p
 = let (g,c) = constraintProgram p
       eqs   = closure c
   in  if    valid (g,c)
       then  Just ( taus        (_pBinds p) eqs
                  , transducers (_pBinds p))
       else  Nothing


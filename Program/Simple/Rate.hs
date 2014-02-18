module Program.Simple.Rate
 ( ratesOfProgram
 , Rate(..)
 ) where

import Program.Simple.Base
import qualified Data.Map as Map
import           Data.Map   (Map)
import qualified Data.Set as Set
import           Data.Set   (Set)

import Control.Arrow

newtype Rate = Rate [Int]
 deriving (Eq, Show)


ratesOfProgram :: Program -> Maybe (Map AId Rate)
ratesOfProgram p
 = let constrs = getConstraints $ _pBinds p
       clo     = closure constrs
       check   = checkFilters constrs clo
   in  case check of
        Nothing
         -> Nothing
        Just ch
         -> Just
          $ mkRates (_pInputs p) (_pBinds p) clo ch


mkRates :: ([AId], [SId]) -> [Bind] -> EquivClass -> Map AId AId -> Map AId Rate
mkRates (ins, _) bs clo filts
 = Map.fromList
 $ concatMap get bs ++ map getIn ins
 where
  get (ABind aid _xx)
   = [(aid, Rate $ rate aid)]
  get _
   = []

  getIn aid
   = (aid, Rate $ rate aid)

  rate aid
   | Just super <- Map.lookup aid filts
   =  r aid : rate super
   | otherwise
   = [r aid]

  r aid
   = unAId $ canonName clo aid
  
  unAId (AId i) = i



data Constraint
 = ConEqual [AId]
 | ConFilt   AId

type ConstraintMap =  Map AId Constraint
type EquivClass    = [Set AId]


getConstraints :: [Bind] -> ConstraintMap
getConstraints bs
 = foldl go Map.empty bs
 where
  go m (ABind n x)
   = Map.insert n (getConstraint x) m

  go m (SBind _ _)
   = m

  getConstraint x
   = case x of
     MapN   _ ins
      -> ConEqual ins
     Filter _ in1
      -> ConFilt  in1
     BPermute _data indices
      -> ConEqual [indices]


closure :: ConstraintMap -> EquivClass
closure m
 = let sets = filter (not . Set.null)
            $ map gen
            $ Map.toList m
   in  squash sets []
 where
  -- Simply generate a set from each constraint
  gen (k, (ConEqual eqs))
   = Set.fromList (k:eqs)
  -- Ignore filter constraints
  gen (k, (ConFilt _from))
   = Set.singleton k

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



-- | Check for ill-formed constraints:
---
--  Filter 'a <= a' is bad, as restricts to 'a=a'
--  For example,
--      bs = filter as
--      cs = map2 bs as
--  produces constraints
--      bs = as =cs
--      bs <? as
--  so after rewriting for equality we get as <? as
--
--  Filter 'a <= b' and 'a <= c' is bad because a mentioned twice in lhs
--  For example,
--      bs = filter as
--      cs = filter as
--      ds = map2 bs cs
--  produces constraints
--      bs <? as
--      cs <? as
--      ds = bs = cs
--  and rewriting equality we get
--      bs <? as
--      bs <? as
checkFilters :: ConstraintMap -> EquivClass -> Maybe (Map AId AId)
checkFilters cs es
 | checkUnique && checkNotFiltSelf
 = Just
 $ Map.fromList canonRhs

 | otherwise
 = Nothing

 where
  -- Extract just filter constraints
  fs
   = Map.mapMaybe isConFilt cs

  isConFilt (ConFilt f) = Just f
  isConFilt _           = Nothing

  -- Constraints with canonical names of lhs and rhs
  canons
   = map (first  $ canonName es)
   $ canonRhs

  -- Constraints with canonical name of rhs, and original name of lhs
  canonRhs
   = map (second $ canonName es)
   $ Map.toList fs

  -- Just the canonical left-hand sides of all filters
  lhses 
   = map fst canons

  -- Check that no name is mentioned twice in left-hand side
  checkUnique
   = Set.size (Set.fromList lhses) == length lhses

  -- Check for filters of form "a <? a"
  checkNotFiltSelf
   = all (\(c,e) -> c /= e) canons


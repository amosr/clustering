{-# LANGUAGE BangPatterns, MagicHash, UnboxedTuples #-}
import Common
import qualified Data.Vector.Unboxed as V
import qualified Data.Vector.Unboxed.Mutable as M
import Control.Monad.ST

import GHC.Exts
import Debug.Trace


{-# NOINLINE quadtree #-}
quadtree :: V.Vector (Int,Int) -> QuadTree
quadtree !pts
 = let box = bounds 0# mini maxi mini maxi
   in  go pts box

 where
  mini =  100000000#
  maxi = -100000000#

  bounds i x1 x2 y1 y2
   | I# i == (V.length pts)
   = (# x1, y1, (x2 +# 1#), (y2 +# 1#) #)
   | otherwise
   = let !(I# x, I# y) = V.unsafeIndex pts (I# i)
         x1' = if x <# x1 then x else x1
         x2' = if x ># x2 then x else x2
         y1' = if y <# y1 then y else y1
         y2' = if y ># y2 then y else y2
     in  bounds (i +# 1#) x1' x2' y1' y2'

  go !ins !box
   | V.length ins == 0
   = Nil
   | V.length ins == 1
   = Leaf (V.head ins)
   | otherwise
   = let (# !b1,!b2,!b3,!b4 #) = splitbox box
         (!p1,!p2,!p3,!p4) = filter4 b1 b2 b3 b4 ins
     in  Tree (go p1 b1) (go p2 b2) (go p3 b3) (go p4 b4)

  {-# INLINE filter4 #-}
  filter4 b1 b2 b3 b4 !inp
   = runST $ do
      v1 <- M.unsafeNew (V.length inp)
      v2 <- M.unsafeNew (V.length inp)
      v3 <- M.unsafeNew (V.length inp)
      v4 <- M.unsafeNew (V.length inp)
      let go l1 l2 l3 l4 i
           | I# i == V.length inp
           = return (I# l1, I# l2, I# l3, I# l4)
           | otherwise
           = do let !e@(I# x, I# y) = V.unsafeIndex inp (I# i)
                I# l1' <- case inbox b1 e of
                        True -> do
                            M.unsafeWrite v1 (I# l1) e
                            return (I# (l1 +# 1#))
                        False -> return (I# l1)
                I# l2' <- case inbox b2 e of
                        True -> do
                            M.unsafeWrite v2 (I# l2) e
                            return (I# (l2 +# 1#))
                        False -> return (I# l2)
                I# l3' <- case inbox b3 e of
                        True -> do
                            M.unsafeWrite v3 (I# l3) e
                            return (I# (l3 +# 1#))
                        False -> return (I# l3)
                I# l4' <- case inbox b4 e of
                        True -> do
                            M.unsafeWrite v4 (I# l4) e
                            return (I# (l4 +# 1#))
                        False -> return (I# l4)
                go l1' l2' l3' l4' (i +# 1#)

      (l1,l2,l3,l4) <- go 0# 0# 0# 0# 0#
      v1' <- V.unsafeFreeze (M.unsafeTake l1 v1)
      v2' <- V.unsafeFreeze (M.unsafeTake l2 v2)
      v3' <- V.unsafeFreeze (M.unsafeTake l3 v3)
      v4' <- V.unsafeFreeze (M.unsafeTake l4 v4)
      return (v1', v2', v3', v4')



main
 = do   sz <- get_size
        let xs  = random_ints 1 sz
        let ys  = random_ints 2 sz
        let pts = V.zip xs ys
        print (V.head pts)
        print (pts V.! 12349)
        let cp = quadtree pts
        print $ tree_size cp
        -- print pts
        -- print cp
        putStr "Ok"


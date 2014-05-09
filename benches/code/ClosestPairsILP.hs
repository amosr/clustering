{-# LANGUAGE BangPatterns, MagicHash, UnboxedTuples #-}
import Common
import qualified Data.Vector.Unboxed as V
import qualified Data.Vector.Unboxed.Mutable as M
import Control.Monad.ST

import GHC.Exts

{-# NOINLINE closestpoints #-}
closestpoints :: V.Vector (Int,Int) -> Int
closestpoints pts
 | V.length pts < 1000
 = naive pts
 | otherwise
 = let !y      = (V.sum $ snd $ V.unzip pts) `div` V.length pts
       (!aboves, !belows)  = filter2 (above y) (below y) pts
       above'  = closestpoints aboves
       below'  = closestpoints belows

       border  = min above' below'

       (!aboveB, !belowB) = filter2 (\p -> below (y - border) p && above border p) (\p -> above (y + border) p && below border p) pts
       -- aboveB  = V.filter (\p -> below (y - border) p && above border p) pts
       -- belowB  = V.filter (\p -> above (y + border) p && below border p) pts
       
       mins    = getMin aboveB belowB border
   in  mins

 where
  {-# INLINE filter2 #-}
  filter2 !p !q !inp
   = runST $ do
      v1 <- M.unsafeNew (V.length inp)
      v2 <- M.unsafeNew (V.length inp)
      let go l1 l2 i
           | I# i == V.length inp
           = return (M.unsafeTake (I# l1) v1, M.unsafeTake (I# l2) v2)
           | otherwise
           = do let !e@(I# x, I# y) = V.unsafeIndex inp (I# i)
                I# l1' <- case p e of
                        True -> do
                            M.unsafeWrite v1 (I# l1) e
                            return (I# (l1 +# 1#))
                        False -> return (I# l1)
                I# l2' <- case q e of
                        True -> do
                            M.unsafeWrite v2 (I# l2) e
                            return (I# (l2 +# 1#))
                        False -> return (I# l2)
                go l1' l2' (i +# 1#)

      (!v1',!v2') <- go 0# 0# 0#
      !v1'' <- V.unsafeFreeze v1'
      !v2'' <- V.unsafeFreeze v2'
      return (v1'', v2'')

  {-# INLINE getMin #-}
  getMin !l !r !(I# minim)
   = let go li ri m
          | I# ri == V.length r
          = I# m
          | I# li == V.length l
          = go (li +# 1#) 0# m
          | otherwise
          = let le    = V.unsafeIndex l (I# li)
                re    = V.unsafeIndex r (I# ri)
                !(I# d) = dist le re
            in  if   d <# m
                then go li (ri +# 1#) d
                else go li (ri +# 1#) m
     in go 0# 0# minim



main
 = do   sz <- get_size
        let xs  = random_ints 1123 sz
        let ys  = random_ints 1124 sz
        let pts = V.zip xs ys
        print (V.head pts)
        let cp = closestpoints pts
        print cp
        putStr "Ok"

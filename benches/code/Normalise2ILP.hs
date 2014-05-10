{-# LANGUAGE MagicHash, UnboxedTuples #-}

import Common
import qualified Data.Vector.Unboxed as V
import GHC.Exts

{-# NOINLINE normalise2 #-}
normalise2 :: V.Vector Int -> (V.Vector Int, V.Vector Int)
normalise2 us
       -- sum1, gts, sum2
 = let (# sum1, sum2 #) = go_sum_gts 0# 0# 0#

       -- nor1, nor2
       nors = V.map (\x -> (x `div` I# sum1, x `div` I# sum2)) us
       -- This is faster, because it doesn't perform /0 checks:
       -- nors = V.map (\(I# x) -> (I# (quotInt# x sum1), I# (quotInt# x sum2))) us
    in nors `seq` V.unzip nors
 where
  go_sum_gts i j k
   | I# i == (V.length us)
   = (# j, k #)
   | otherwise
   = let I# n = V.unsafeIndex us (I# i)
     in  if   n ># 0#
         then go_sum_gts (i +# 1#) (j +# n) (k +# n)
         else go_sum_gts (i +# 1#) (j +# n)  k

main
 = do   sz <- get_size
        let v = random_ints 1123 sz
        print (V.head v)
        let (a,b) = normalise2 v
        print (V.head a, V.head b)
        a `seq` b `seq` putStr "Ok"

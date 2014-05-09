import Common
import qualified Data.Vector.Unboxed as V

{-# NOINLINE normalise2 #-}
normalise2 :: V.Vector Int -> (V.Vector Int, V.Vector Int)
normalise2 us
 = let sum1 = V.foldl' (+) 0  us
       gts  = V.filter (>0) us
       sum2 = V.foldl' (+) 0  gts

       nor1 = V.map (`div` sum1) us
       nor2 = V.map (`div` sum2) us
    in (nor1, nor2)

main
 = do   sz <- get_size
        let v = random_ints 1123 sz
        print (V.head v)
        let (a,b) = normalise2 v
        print (V.head a, V.head b)
        a `seq` b `seq` putStr "Ok"

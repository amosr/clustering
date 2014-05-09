import Common
import qualified Data.Vector.Unboxed as V

{-# NOINLINE closestpoints #-}
closestpoints :: V.Vector (Int,Int) -> Int
closestpoints pts
 | V.length pts < 1000
 = naive pts
 | otherwise
 = let y       = (V.sum $ snd $ V.unzip pts) `div` V.length pts
       {-# NOINLINE aboves #-}
       aboves  = V.filter (above y) pts
       {-# NOINLINE belows #-}
       belows  = V.filter (below y) pts
       above'  = closestpoints aboves
       below'  = closestpoints belows

       border  = min above' below'

       {-# NOINLINE aboveB #-}
       aboveB  = V.filter (\p -> below (y - border) p && above border p) pts
       {-# NOINLINE belowB #-}
       belowB  = V.filter (\p -> above (y + border) p && below border p) pts
       
       {-# NOINLINE dists #-}
       dists   = V.concatMap (\p -> V.map (dist p) belowB) aboveB
       {-# NOINLINE mins #-}
       mins    = V.foldl min border dists
   in  mins

main
 = do   sz <- get_size
        let xs  = random_ints 1123 sz
        let ys  = random_ints 1124 sz
        let pts = V.zip xs ys
        print (V.head pts)
        let cp = closestpoints pts
        print cp
        putStr "Ok"

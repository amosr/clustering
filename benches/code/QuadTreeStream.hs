{-# LANGUAGE BangPatterns, MagicHash, UnboxedTuples #-}
import Common
import qualified Data.Vector.Unboxed as V
import qualified Data.Vector.Unboxed.Mutable as M
import Control.Monad.ST

import GHC.Exts
import Debug.Trace


{-# NOINLINE quadtree #-}
quadtree :: V.Vector (Int,Int) -> QuadTree
quadtree pts
 = let box = bounds
   in  go pts box

 where
  bounds
   = let (xs, ys) = V.unzip pts
         I# x1 = V.minimum xs
         I# x2 = V.maximum xs
         I# y1 = V.minimum ys
         I# y2 = V.maximum ys
     in (# x1, y1, x2 +# 1#, y2 +# 1# #)

  go ins box
   | V.length ins == 0
   = Nil
   | V.length ins == 1
   = Leaf (V.head ins)
   | otherwise
   = let (# b1,b2,b3,b4 #) = splitbox box
         p1               = V.filter (inbox b1) ins
         p2               = V.filter (inbox b2) ins
         p3               = V.filter (inbox b3) ins
         p4               = V.filter (inbox b4) ins
     in  Tree (go p1 b1) (go p2 b2) (go p3 b3) (go p4 b4)


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


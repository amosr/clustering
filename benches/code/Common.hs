{-# LANGUAGE BangPatterns, MagicHash, UnboxedTuples #-}
module Common where
import qualified Data.Vector.Unboxed as V
import System.Environment
import System.Random
import GHC.Exts

get_size :: IO Int
get_size
 = do   n <- getArgs
        case n of
         [sz] -> return $ read sz
         _ -> error "Usage: bench <data-size>"

random_ints :: Int -> Int -> V.Vector Int
random_ints seed sz
 = V.generate sz (\i -> (i * seed * 512354 + 1234824))

-- naive closest points
{-# NOINLINE naive #-}
naive :: V.Vector (Int,Int) -> Int
naive pts
 = V.minimum
 $ V.concatMap (\p -> V.map (check p) pts) pts
 where
  check p1@(x1,y1) p2@(x2,y2)
   | p1 == p2
   = 100000000 -- infinite...
   | otherwise
   = dist (x1 - x2) (y1 - y2)

  dist x y = truncate $ sqrt $ fromIntegral $ x * x + y * y

dist :: (Int,Int) -> (Int,Int) -> Int
dist (x1,y1) (x2,y2) = dist' (x1 - x2) (y1 - y2)
 where
  dist' x y = truncate $ sqrt $ fromIntegral $ x * x + y * y

above :: Int -> (Int,Int) -> Bool
above y1 (x2,y2)
 = y1 >= y2
below :: Int -> (Int,Int) -> Bool
below y1 (x2,y2)
 = y1 <  y2


data QuadTree
 = Leaf (Int,Int)
 | Nil
 | Tree QuadTree QuadTree QuadTree QuadTree
 deriving Show

type Box = (# Int#, Int#, Int#, Int# #)

{-# INLINE inbox #-}
inbox :: Box -> (Int,Int) -> Bool
inbox (# tlx, tly, brx, bry #) (x,y)
 =  x >= I# tlx
 && x <  I# brx
 && y >= I# tly
 && y <  I# bry

{-# INLINE splitbox #-}
splitbox :: Box -> (# Box, Box, Box, Box #)
splitbox (# tlx, tly, brx, bry #)
 = let !(I# mx) = (I# tlx + I# brx) `div` 2
       !(I# my) = (I# tly + I# bry) `div` 2
   in (# (# tlx, tly,  mx ,  my #)
      , (#  mx, tly, brx ,  my #)
      , (# tlx,  my,  mx , bry #)
      , (#  mx,  my, brx , bry #) #)

{-# INLINE tree_size #-}
tree_size :: QuadTree -> Int
tree_size (Leaf _)
 = 1
tree_size Nil
 = 0
tree_size (Tree a b c d)
 = tree_size a + tree_size b + tree_size c + tree_size d


module Common where
import qualified Data.Vector.Unboxed as V
import System.Environment
import System.Random

get_size :: IO Int
get_size
 = do   n <- getArgs
        case n of
         [sz] -> return $ read sz
         _ -> error "Usage: bench <data-size>"

random_ints :: Int -> Int -> V.Vector Int
random_ints seed sz
 = V.generate sz (\i -> (i * seed * 512354 + 1234824) `mod` 12349)

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


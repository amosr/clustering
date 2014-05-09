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


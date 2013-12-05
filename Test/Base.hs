module Test.Base
 ( module Graph
 , module Test.Framework
 , module Test.Framework.TH
 , module Test.Framework.Providers.QuickCheck2
 , module Test.QuickCheck

 , forAllMaybe 
 ) where

import Graph

import Test.Framework
import Test.Framework.TH
import Test.Framework.Providers.QuickCheck2

import Test.QuickCheck


forAllMaybe :: (Show a, Testable prop) => Gen (Maybe a) -> (a -> prop) -> Property
forAllMaybe g f
 =  forAll g $ \e
 -> case e of
     Nothing -> property True
     Just e' -> property $ f e'

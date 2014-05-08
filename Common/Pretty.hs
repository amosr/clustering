module Common.Pretty where

class Pretty a where
 ppr :: a -> String


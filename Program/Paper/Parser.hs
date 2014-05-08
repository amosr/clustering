module Program.Paper.Parser where
import Program.Paper.Base
import Control.Monad
import Data.Tuple

data ParseResult
 = ParseResult
 { _prProgram :: Program
 , _prANames  :: [(AId, String)]
 , _prSNames  :: [(SId, String)]
 , _prAFresh  :: Int
 , _prSFresh  :: Int
 }
 deriving (Show)

data Error
 = ErrorUnexpected String
 | ErrorNoSuchVar String
 | ErrorNoSuchVarSCALAR String
 | ErrorNoSuchVarARRAY  String
 deriving (Show)

parse :: String -> Either Error ParseResult
parse inps
 = let ls = lines inps
   in  foldM go empty ls
 where
  empty  = ParseResult emptyP [] [] 0 0
  emptyP = Program ([],[]) [] ([],[])

  go m line
   | ws <- tokenise line
   = case ws of
     []
      -> return m

     ["param", "array", xs]
      -> let (a, m') = freshA m xs
         in return $ addInpA m' a

     ["param", "scalar", xs]
      -> let (a, m') = freshS m xs
         in return $ addInpS m' a

     ["return", xs]
      -> case getA m xs of
         Just a  -> return $ addOutA m a
         Nothing ->
          case getS m xs of
          Just s -> return $ addOutS m s
          Nothing -> Left (ErrorNoSuchVar xs)
     (xs : "=" : rest)
      -> nor m xs rest
     others
      -> external m others

  nor m xs (comb:rest)
   = case comb of
     "reduce"
      -> do (f,rest') <- getFun m rest
            case rest' of
             [x]
              -> do x' <- checkA m x
                    let (a, m') = freshS m xs
                    let       b = SBind a (Reduce f x')
                    return $ addBind m' b
             _
              -> Left $ ErrorUnexpected $ unwords rest'
     "filter"
      -> do (f,rest') <- getFun m rest
            case rest' of
             [x]
              -> do x' <- checkA m x
                    let (a, m') = freshA m xs
                    let       b = ABind a (Filter f x')
                    return $ addBind m' b
             _
              -> Left $ ErrorUnexpected $ unwords rest'
     "generate"
      -> case rest of
         (x:rest')
          -> do x' <- checkS m x
                (f,_) <- getFun m rest'
                let (a, m') = freshA m xs
                return $ addBind m' (ABind a (Generate x' f))
         _
          -> Left $ ErrorUnexpected $ unwords rest
     "gather"
      -> case rest of
         [x,y]
          -> do x' <- checkA m x
                y' <- checkA m y
                let (a, m') = freshA m xs
                return $ addBind m' (ABind a (BPermute x' y'))
         _
          -> Left $ ErrorUnexpected $ unwords rest
     "cross"
      -> case rest of
         [x,y]
          -> do x' <- checkA m x
                y' <- checkA m y
                let (a, m') = freshA m xs
                return $ addBind m' (ABind a (Cross x' y'))
         _
          -> Left $ ErrorUnexpected $ unwords rest
     "mapN"
      -> do (f,rest') <- getFun m rest
            xs' <- mapM (checkA m) rest'
            let (a, m') = freshA m xs
            let       b = ABind a (MapN f xs')
            return $ addBind m' b
     "external"
      -> external m (xs : "=" : comb : rest)
     _
      -> Left $ ErrorUnexpected $ unwords (comb : rest)

  external m ws
   = do (m',pre,rest) <- getexts_pre m ws
        case rest of
         "=" : "external" : rest'
          -> do (post,r'') <- getexts_post m' rest'
                case r'' of
                 []
                  -> return $ addBind m' (External pre post)
                 _
                  -> Left $ ErrorUnexpected $ unwords r''
         _
          -> Left $ ErrorUnexpected $ unwords rest

  getexts_pre m ("{":rs)
   = do    (m',ss,rs') <- getexts_pre_s m rs
           return (m',([],ss),rs')
  getexts_pre m (x:rs)
   = do    let (x', m') = freshA m x
           (m'',(as,ss),rs') <- getexts_pre m' rs
           return (m'',(x':as,ss),rs')

  getexts_pre_s m ("}":rs)
   = return (m, [], rs)
  getexts_pre_s m (s:rs)
   = do let (s', m') = freshS m s
        (m'', xs, rs)   <- getexts_pre_s m' rs
        return (m'', s':xs, rs)




  getexts_post m []
   = return (([],[]),[])

  getexts_post m ("{":rs)
   = do    (ss,rs') <- goFun m rs
           return (([],ss),rs')
  getexts_post m (x:rs)
   = do    x' <- checkA m x
           ((as,ss),rs') <- getexts_post m rs
           return ((x':as,ss),rs')



  getFun m ("{":rs)
   = do (fs,rest) <- goFun m rs
        return (Fun fs, rest)
  getFun m rs
   = do return (Fun [], rs)



  goFun m ("}":rs)
   = return ([], rs)
  goFun m (s:rs)
   = case getS m s of
     Nothing ->
      Left (ErrorNoSuchVarSCALAR s)
     Just s'
      -> do (xs, rs) <- goFun m rs
            return (s':xs, rs)


  checkA m str
   = case getA m str of
     Nothing
      -> Left (ErrorNoSuchVarARRAY str)
     Just x'
      -> return x'

  checkS m str
   = case getS m str of
     Nothing
      -> Left (ErrorNoSuchVarSCALAR str)
     Just x'
      -> return x'


  getA m str
   = lookup str
   $ map swap
   $ _prANames m

  getS m str
   = lookup str
   $ map swap
   $ _prSNames m

  freshA m xs
   = let n  = _prAFresh m
         a  = AId n
         m' = m { _prAFresh = n + 1
                , _prANames = (a,xs) : _prANames m }
     in (a, m')

  freshS m xs
   = let n  = _prSFresh m
         a  = SId n
         m' = m { _prSFresh = n + 1
                , _prSNames = (a,xs) : _prSNames m }
     in (a, m')

  addInpA m a
   = let p         = _prProgram m
         (inA,inS) = _pInputs p
         p'        = p { _pInputs = (inA ++ [a], inS) }
     in m { _prProgram = p' }

  addInpS m a
   = let p         = _prProgram m
         (inA,inS) = _pInputs p
         p'        = p { _pInputs = (inA, inS ++ [a]) }
     in m { _prProgram = p' }

  addOutA m a
   = let p           = _prProgram m
         (outA,outS) = _pOutputs p
         p'          = p { _pOutputs = (outA ++ [a], outS) }
     in m { _prProgram = p' }

  addOutS m a
   = let p           = _prProgram m
         (outA,outS) = _pOutputs p
         p'          = p { _pOutputs = (outA, outS ++ [a]) }
     in m { _prProgram = p' }

  addBind m b
   = let p           = _prProgram m
         binds       = _pBinds p
         p'          = p { _pBinds = (binds ++ [b]) }
     in m { _prProgram = p' }


tokenise :: String -> [String]
tokenise str
 = tok str
 where
  tok ('#': _)
   = []
  tok ('=': rs)
   = "=" : tok rs
  tok ('{': rs)
   = "{" : tok rs
  tok ('}': rs)
   = "}" : tok rs
  tok (' ': rs)
   = tok rs
  tok ('\t': rs)
   = tok rs
  tok (a:rs)
   | isAlphaNum a
   = takeWhile isAlphaNum (a:rs)
   : tok (dropWhile isAlphaNum rs)
  tok (a:rs)
   = [a] : tok rs -- ?

  tok []
   = []

  isAlphaNum a
   = elem a (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9'] ++ ['\''])


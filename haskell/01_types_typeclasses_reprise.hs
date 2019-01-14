import qualified Data.Map as Map {-For lockerLookup-}

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

factorial :: Integer -> Integer  
factorial n = product [1..n]  


{-SHAPE and POINT-}
{-Shape is a newly define type wich can be either a Circle or a Rectangle. Since Shape is-}
{-deriving Show we can say that Shape is part of the Show typeclass-}
{-N.B.: Circle and Rectangle are not types! They are just value constructors-}
{-FIRST IMPLEMENTATION-}
{-data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)-}

{-Here we use pattern matching with Circle and Rectangle-}
{-surface :: Shape -> Float-}
{-surface (Circle _ _ r) = pi * r^2-}
{-surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)-}

{-Redefine the Shape type introducing the concept of Point first.-}
data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

{-Now we can redefine the surface function-}
surface :: Shape -> Float
surface (Circle _ r) = pi * r^2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

{-RECORD SYNTAX-}
data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String
                     } deriving (Eq, Show)
tom = Person "Tommaso" "Sardelli" 26 1.75 "5" "Tottolato"
ema = Person {firstName="Emanuela"
             , lastName="Meli"
             , age = 27
             , height=1.50
             , phoneNumber = "7"
             , flavor="Strawberry"
             }

{-TYPE PARAMETERS-}

{-Maybe-}
randomChoose :: Int -> Maybe Char
randomChoose select
  | select <= 10 = Nothing
  | otherwise = Just 'a'

{-Vectors-}
data Vector a = Vector a a a deriving (Show)  
  
vplus :: (Num t) => Vector t -> Vector t -> Vector t  
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)  
  
vectMult :: (Num t) => Vector t -> t -> Vector t  
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)  
  
scalarMult :: (Num t) => Vector t -> Vector t -> t  
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n  

{-DAYS-}
data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
    deriving (Eq, Ord, Show, Read, Bounded, Enum)

{-EITHER-}
{-import qualified Data.Map as Map-}

data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
    case Map.lookup lockerNumber map of
      Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
      Just (state, code) -> if state /= Taken
                              then Right code
                              else Left $ "Locker number " ++ show lockerNumber ++ " is already taken!"

lockers = Map.fromList   
    [(100,(Taken,"ZD39I"))  
    ,(101,(Free,"JAH3I"))  
    ,(103,(Free,"IQSA9"))  
    ,(105,(Free,"QOTSA"))  
    ,(109,(Taken,"893JJ"))  
    ,(110,(Taken,"99292"))  
    ] :: LockerMap  

infixr 5 :-:
data MyList a = Empty | a :-: (MyList a) deriving (Show, Read, Eq, Ord)

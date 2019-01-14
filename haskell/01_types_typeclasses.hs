-- Shapes
-- data Shape = Circle Float Float Float | Rectangle Float Float Float Float   
-- surface :: Shape -> Float  
-- surface (Circle _ _ r) = pi * r ^ 2  
-- surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1) 

data Point = Point Float Float deriving (Show)  
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)  
surface :: Shape -> Float  
surface (Circle _ r) = pi * r ^ 2  
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)  

-- Person
data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNymber :: String
                     , flavor :: String
                     } deriving (Show)

-- Car using data types
data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)

-- Vector using parametrized type because they can be different (numerical) types (Int, Float, Double, etc.)
data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n) 

vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m) 

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n

-- Recursive data types
--data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)
-- Same thing but using an infix operator of special charachters (:-:)
infixr 5 :-: --Associativity and priority of the operator
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)

-- Binary trees
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)
-- Function that creates a node from an value with two empty subtrees (starting point)
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree
-- Insert an element in the tree
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x < a = Node a (treeInsert x left) right
    | x > a = Node a left (treeInsert x right)
-- Check if an element is in the tree
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a = treeElem x left
    | x > a = treeElem x right



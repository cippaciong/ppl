factorial :: Integer -> Integer
factorial n = product [1..n]

factorial' :: Integer -> Integer
factorial' 0 = 1
factorial' n = n * factorial' (n-1)

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2

maximum' :: (Ord a) => [a] -> a
maximum' []     = error "maximum of empty list"
maximum' [x]    = x
maximum' (x:xs) = max x (maximum' xs)

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' count element
    | count <= 0 = []
    | otherwise = element:replicate' (count -1) element

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
  | n <=0 = []
take' _ xs
  | null xs = []
take' n (x:xs) = x:take' (n-1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

zip' :: [a] -> [b] -> [(a,b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = [(x, y)] ++ zip' xs ys

quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) =
    let smallerList = quicksort' [e | e <- xs, e <= x]
        biggerList  = quicksort' [e | e <- xs, e >= x]
     in smallerList ++ [x] ++ biggerList


{-Higher order functions-}
mulThree :: (Num a) => a -> a -> a -> a
mulThree x y z = x * y * z

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

createPair :: a -> b -> (a, b)
createPair a b = (a, b)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y:zipWith' f xs ys

flip' :: (a -> b -> c) -> b -> a -> c
flip' x y z = x z y

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
  | f x == True = x:filter' f xs
  | otherwise = filter' f xs

quicksort'' :: (Ord a) => [a] -> [a]
quicksort'' [] = []
quicksort'' (x:xs) =
    let smallerList = quicksort'' (filter' (<= x) xs)
        biggerList  = quicksort'' (filter' (>= x) xs)
     in smallerList ++ [x] ++ biggerList


{-Recursive data structures-}

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

{-Tree Functions: Create a new singleton tree, starting from a value-}
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

{-Insert an element in an existing tree-}
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a  = Node a (treeInsert x left) right
  | x > a  = Node a left (treeInsert x right)

{-Check if some element is in the tree-}
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
  | x == a = True
  | x < a = treeElem x left
  | x > a = treeElem x right


{-MONAAAAADS-}

{-do notation-}
doubleSquare :: (Monad f, Num a) => f a -> f a
doubleSquare x = let fsquare = (\x -> return (x^2))
            {-in x >>= fsquare >>= fsquare-}
            in do
                 start <- x
                 second <- fsquare start
                 fsquare second

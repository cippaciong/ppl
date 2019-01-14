add :: Int -> Int -> Int
add x y = x + y

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!" --catch-all pattern

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

-- Recursive factorial with pattern matching
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Sum of vectors w/o and w/ pattern mathing
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)

addVectors' :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors' (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

-- Use pattern matching to adapt fst, snd (and third) to triples
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- Pattern matching in list comprehension
--let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
--[a+b | (a,b) <- xs]

-- Pattern matching against lists
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x

firstTwo' :: [a] -> [a]
firstTwo' [] = error "Can't call firstTwo on an empty list, dummy!"
firstTwo' (x:[]) = error "Can't call firstTwo on a list of one element, dummy!"
firstTwo' (x:y:_) = [x,y]

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length'(xs)

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- Recursion with pattern mathing and guards
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

-- Another implementation of maximum using `max` with a pair of numbers
maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "maximum of empty list"
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum'' xs)

-- Replicate takes two Integers a and b and create a list with a occurrences of b (e.g. 3, 5 -> [5, 5, 5])
replicate' :: (Integral a) => a -> a -> [a]
replicate' 0 _ = []
replicate' x y = y:replicate' (x-1) y


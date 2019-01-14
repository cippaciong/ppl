-- Consider the following binary tree data structure
data Tree a = Nil | Leaf a | Branch (Tree a)(Tree a) deriving (Show, Eq)

-- Define a tcompose operation, which takes a function f and two trees, t1 and t2,
-- and returns a tree with the same structure as t1, but with leaves replaced
-- by subtrees having the same structure of t2: each leaf is obtained by
-- applying f to the value stored in the previous leaf, and the corresponding value in t2.
-- E.g.
-- t1 = Branch (Branch (Leaf 1) (Leaf 2)) (Leaf 3)
-- t2 = Branch (Leaf 6) (Leaf 7)
-- tcompose (+) t1 t2 is
-- Branch (Branch (Branch (Leaf 7) (Leaf 8)) (Branch (Leaf 8) (Leaf 9))) (Branch (Leaf 9) (Leaf 10))

tmap :: (a -> a) -> Tree a -> Tree a
tmap f Nil = Nil
tmap f (Leaf x) = Leaf $ f x
tmap f (Branch l r) = Branch (tmap f l) (tmap f r)

apply :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
apply _ Nil _ = Nil
apply fn (Leaf val) t = tmap (fn val) t
apply fn (Branch l r) t = Branch (apply fn l t) (apply fn r t)

tcompose :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
tcompose _ Nil _ = Nil
tcompose _ x Nil = x
tcompose fn t1 t2 = apply fn t1 t2


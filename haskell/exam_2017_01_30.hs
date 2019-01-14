-- Define a data structure, called Lt, for generic list of lists, where each list
-- has a fixed length and such number is stored in the data structure.
data Lt a = Lt Int [[a]] deriving (Show, Eq)


-- Define a function, called checkLt, that takes an Lt and returns
-- true if it is valid (i.e. every list in it have the correct size)
-- false otherwise.

checkLt :: Lt a -> Bool
checkLt (Lt len lst)
  = foldl (\a x -> a && (length x == len)) True lst


-- Define a function, called checklist, that takes a list t and an Lt, checks
-- if all the sublists of t are in the given Lt, and uses Maybe to return
-- the list of sublists of t that are not present in Lt.
-- Note: sublists must be contiguous, e.g.
-- the sublists of size 2 of [1,2,3] are [1,2], [2,3].
sublists :: (Eq a) => [a] -> Lt a -> [[a]] -> [[a]]
sublists lst (Lt len lt) res
  | (length lst < len) = res
  | otherwise =
      let subl = take len lst in
          if (elem subl lt) then
             sublists (tail lst) (Lt len lt) res
         else
             sublists (tail lst) (Lt len lt) (res ++ [subl])

checklist :: (Eq a) => [a] -> Lt a -> Maybe [[a]]
checklist lst (Lt len lt) =
    let res = sublists lst (Lt len lt) [] in
        if res == []
           then Nothing
           else Just res


-- Make Lt an instance of Functor.
instance Functor Lt where
    fmap _ (Lt 0 _) = (Lt 0 [])
    fmap f (Lt len lst) = (Lt len (map f lst))

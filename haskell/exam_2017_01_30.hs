-- Define a data structure called Lt, for generic list of lists, where each list has
-- a fixed length and such number is stored in the data structure
data Lt a = Lt Int [[a]] deriving (Show, Eq)

-- Define a function, called checkLt, that takes an Lt and returns
-- true if it is valid (i.e. every list in it have the correct size)
-- false otherwise
checkLt :: Lt a -> Bool
checkLt (Lt _ []) = True
checkLt (Lt a b) = all (== a) $ map length b

-- Define a function, called checklist, that takes a list t and an Lt
-- checks if all the sublists of t are in the given Lt
-- and uses Maybe to return the list of sublists of t that are not present in Lt.
-- Note: sublists must be contiguous, e.g. the sublists of size 2 of [1,2,3] are [1,2], [2,3].
sublists :: Int -> [a] -> [[a]] -> [[a]]
sublists size lst res =
    let subl = take size lst in
        if length subl == size
           then sublists size (tail lst) (subl:res)
       else res

checklist :: (Eq a) => [a] -> Lt a -> Maybe [[a]]
checklist lst (Lt size ltf) =
    let factors = sublists size lst []
        nfactors = [x | x <- factors, not (x `elem` ltf)] in
            if nfactors == []
               then Nothing
           else Just nfactors

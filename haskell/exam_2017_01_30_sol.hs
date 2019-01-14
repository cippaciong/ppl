data Lt a = Lt Int [[a]] deriving (Show, Eq)

checkLt :: Lt a -> Bool
checkLt (Lt _ []) = True
checkLt (Lt k (x:xs)) = length x == k && checkLt (Lt k xs)

sublists :: Int -> [a] -> [[a]] -> [[a]]
sublists size lst res =
    let factor = take size lst in
        if length factor == size
        then sublists size (tail lst) (factor:res)
        else res

checklist :: Eq a => [a] -> Lt a -> Maybe [[a]]
checklist lst (Lt size ltf) =
    let factors = sublists size lst []
        nfactors = [x | x <- factors, not (x `elem` ltf)]
     in if nfactors == [] then Nothing else Just nfactors

instance Functor Lt where
    fmap f (Lt k lst) = Lt k $ map (\x -> map f x) lst

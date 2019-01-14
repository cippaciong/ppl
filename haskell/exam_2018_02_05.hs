{-Define a Graph data-type, for directed graphs.
  Nodes hold some generic data, while edges have no data associated-}
data Node a b = Node {
                  node_id :: a,
                  datum :: b,
                  adjacent :: [a]
                  } deriving Show

data Graph a b = Graph [Node a b] deriving Show


{-Define a graph_lookup function, to get the data associated with a node in the graph
  (or nothing if the node is not present)-}
graph_lookup :: (Eq a) => Graph a b -> a -> Maybe b
graph_lookup  (Graph []) lookup_id = Nothing
graph_lookup (Graph ((Node node_id datum _):xs)) lookup_id = if node_id == lookup_id
                                            then Just datum
                                            else graph_lookup (Graph xs) lookup_id


{-Define an adjacents function, to check if two nodes are adjacent or not.-}
adjacents :: (Eq a) => Node a b -> Node a b -> Bool
adjacents (Node id_a _ adj_a) (Node id_b _ adj_b)
  | id_b `elem` adj_a || id_a `elem` adj_b = True
  | otherwise = False


{-Make Graph an instance of Functor.-}
instance Functor (Node a) where
  fmap f (Node node_id datum adj) = (Node node_id (f datum) adj)

instance Functor (Graph a) where
  fmap f (Graph nodes) = (Graph (fmap (\x -> fmap f x) nodes))

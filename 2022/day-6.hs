import Flow

uniq :: (Eq a ) => [a] -> [a]
uniq = uniq' []

uniq' :: (Eq a) => [a] -> [a] -> [a]
uniq' _ [] = []
uniq' preceeding (x:xs) | elem x preceeding = uniq' preceeding xs
                        | True = x:(uniq' (x:preceeding) xs)

markerLocation :: (Eq a) => Integer -> [a] -> Integer
markerLocation = markerLocation' 0

markerLocation' :: (Eq a) => Integer -> Integer -> [a] -> Integer
markerLocation' idx qty l | l |> take (fromInteger qty) |> uniq |> length |> toInteger |> (== qty) = idx + qty
                 | True = markerLocation' (idx + 1) qty (tail l)

main = do
  contents <- readFile $ "day-6-input.txt"

  print $ "Part 1: " ++ show (markerLocation 4 contents)
  print $ "Part 2: " ++ show (markerLocation 14 contents)

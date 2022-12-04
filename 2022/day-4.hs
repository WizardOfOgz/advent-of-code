import Data.List.Split (splitOn)

filterEmptyString :: [String] -> [String]
filterEmptyString = filter ((> 0) . length)

parseInteger :: String -> Integer
parseInteger t = read t :: Integer

parseInput :: String -> [[Char]]
parseInput = filterEmptyString . splitOn "\n"

cover :: (Integer, Integer) -> (Integer, Integer) -> Bool
cover (start1, end1) (start2, end2) = start1 <= start2 && start2 <= end1 && start1 <= end2 && end2 <= end1

coverOrContained :: [[Integer]] -> Bool
coverOrContained ((start1:end1:[]):(start2:end2:[]):[]) = cover (start1, end1) (start2, end2) || cover (start2, end2) (start1, end1)

overlap :: [[Integer]] -> Bool
overlap ((start1:end1:[]):(start2:end2:[]):[]) = start2 <= end1 && start1 <= end2

main = do
  contents <- readFile $ "day-4-input.txt"
  let input = parseInput contents

  let elfPairs = map (map (map parseInteger . splitOn "-") . splitOn ",") input
  let result1 = length $ filter coverOrContained elfPairs
  print $ "Part 1: " ++ show (result1)

  let result2 = length $ filter overlap elfPairs
  print $ "Part 2: " ++ show (result2)

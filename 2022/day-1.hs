import Data.List (sort)
import Data.List.Split (splitOn)

divideInventoryByElf :: String -> [String]
divideInventoryByElf = splitOn "\n\n"

parseInt :: String -> Int
parseInt t = read t :: Int

-- Example: "1\n2\n3" -> [1, 2, 3]
parseInventory :: String -> [Int]
parseInventory = map parseInt . filter ((> 0) . length) . splitOn "\n"

maxElement :: (Ord a) => [a] -> a
maxElement = foldl1 max

sumTop3 :: [Int] -> Int
sumTop3 = foldl1 (+) . take 3 . reverse . sort

main = do
  input <- readFile "day-1-input.txt"

  let elfInventories = (map parseInventory) . divideInventoryByElf $ input
  let totalsPerElf = map (foldl1 (+)) elfInventories
  print $ "Part 1: " ++ show (maxElement totalsPerElf)
  print $ "Part 2: " ++ show (sumTop3 totalsPerElf)

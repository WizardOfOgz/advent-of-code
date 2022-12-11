import Flow
import Data.List (isPrefixOf)
import Data.List.Split (splitOn)
import Data.Map (Map, fromList, (!))

filterEmptyString :: [String] -> [String]
filterEmptyString = filter ((> 0) . length)

parseInput :: String -> [[Char]]
parseInput = filterEmptyString . splitOn "\n"

main = do
  contents <- readFile $ "day-8-input.txt"
  let input = parseInput contents

  -- scan input ::

  print $ "Part 1: "
  print $ "Part 2: "

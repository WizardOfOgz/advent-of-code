import Data.List.Split (splitOn)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Ix (inRange)
import Data.Char (ord)

filterEmptyString :: [String] -> [String]
filterEmptyString = filter ((> 0) . length)

parseInput :: String -> [[Char]]
parseInput = filterEmptyString . splitOn "\n"

getCompartments :: String -> (String, String)
getCompartments s = (take (div (length s) 2) s, drop (div (length s) 2) s)

getShared :: (String, String) -> [Char]
getShared (s1, s2) = Set.toList $ Set.intersection (Set.fromList s1) (Set.fromList s2)

getPriority :: Char -> Int
getPriority c | (inRange ('a','z') c) = (ord c) - (ord 'a') + 1
              | (inRange ('A','Z') c) = (ord c) - (ord 'A') + 27

chunk :: Integer -> [a] -> [[a]]
chunk n [] = []
chunk n xs = (take 3 xs):(chunk n $ drop 3 xs)

main = do
  contents <- readFile $ "day-3-input.txt"
  let input = parseInput contents

  let result1 = sum $ input >>= ((map getPriority) . getShared . getCompartments)
  print $ "Part 1: " ++ show (result1)

  let result2 = sum $ chunk 3 input >>= (map getPriority) . (foldl1 (\a b -> getShared (a,b)))
  print $ "Part 2: " ++ show (result2)

import Data.List.Split (splitOn)
import Data.List (isPrefixOf)
import Text.Regex.TDFA
import Flow

import Debug.Trace (trace)
import Data.Text (intercalate)

stacks = map reverse [
    ['N','R','G','P'],
    ['J','T','B','L','F','G','D','C'],
    ['M','S','V'],
    ['L','S','R','C','Z','P'],
    ['P','S','L','V','C','W','D','Q'],
    ['C','T','N','W','D','M','S'],
    ['H','D','G','W','P'],
    ['Z','L','P','H','S','C','M','V'],
    ['R','P','F','L','W','G','Z']
  ]

filterEmptyString :: [String] -> [String]
filterEmptyString = filter ((> 0) . length)

parseInput :: String -> [[Char]]
parseInput = filterEmptyString . splitOn "\n"

parseInteger :: String -> Integer
parseInteger t = read t :: Integer

extractMatch :: String -> (Int, Int) -> String
extractMatch s (idx, len) = s |> drop idx |> take len

parseLine :: String -> [Integer]
parseLine line = map (read . extractMatch line) idxs where
  (_:idxs) = getAllSubmatches (line =~ "move ([[:digit:]]+) from ([[:digit:]]+) to ([[:digit:]]+)") :: [(Int, Int)]

pop :: Integer -> [[a]] -> (a, [[a]])
pop 1 ((x:xs):rest) = (x, xs:rest)
pop n (x:xs) = (c, x:stacks) where
  (c, stacks) = pop (n - 1) xs

push :: Integer -> a -> [[a]] -> [[a]]
push 1 c (x:xs) = (c:x):xs
push n c (x:xs) = x:(push (n - 1) c xs)

exec :: [Integer] -> [[a]] -> [[a]]
exec (0:_) stacks = stacks
exec (qty:source:dest:_) stacks = exec [(qty - 1), source, dest] (push dest val poppedStacks) where
  (val, poppedStacks) = pop source stacks

run :: ([Integer] -> [[a]] -> [[a]]) -> [[Integer]] -> [[a]] -> [[a]]
run f [] stacks = stacks
run f (cmd:rest) stacks = run f rest (f cmd stacks) where
  (qty:source:dest:_) = cmd

execPop :: Integer -> Integer -> [[a]] -> ([a], [[a]])
execPop = execPop' []

execPop' :: [a] -> Integer -> Integer -> [[a]] -> ([a], [[a]])
execPop' poppedValues 0 _ stacks = (poppedValues, stacks)
execPop' poppedValues qty source stacks = execPop' (val:poppedValues) (qty - 1) source poppedStacks where
  (val, poppedStacks) = pop source stacks

execPush :: [a] -> Integer -> [[a]] -> [[a]]
execPush [] _ stacks = stacks
execPush (c:cs) dest stacks = execPush cs dest pushedStacks where
  pushedStacks = push dest c stacks

move :: [Integer] -> [[a]] -> [[a]]
move (qty:source:dest:_) stacks = execPush poppedValues dest poppedStacks where
  (poppedValues, poppedStacks) = execPop qty source stacks

main = do
  contents <- readFile $ "day-5-input.txt"
  let input = parseInput contents |> filter (isPrefixOf "move") |> map parseLine

  let result1 = run exec input stacks
  print $ map head result1

  let result2 = run move input stacks
  print $ map head result2

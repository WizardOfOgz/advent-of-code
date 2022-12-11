import Flow
import Data.List (isPrefixOf)
import Data.List.Split (splitOn)
import Data.Map (Map, fromList, (!))

data File = File { fname :: String
                 , size :: Integer
                 } deriving (Show)
data Dir = Dir { dname :: String
               , parent :: Maybe Dir
               , dirs :: Map String Dir
               , files :: Map String File
               }

instance Show Dir where
  show Dir{dname=dname} = dname


filterEmptyString :: [String] -> [String]
filterEmptyString = filter ((> 0) . length)

parseInput :: String -> [[Char]]
parseInput = filterEmptyString . splitOn "\n"

fs = Dir { dname = "/", parent = Nothing, dirs = fromList [], files = fromList [] }

root :: Dir -> Dir
root dir@Dir{parent=Nothing} = dir
root Dir{parent=(Just parent)} = root parent

main = do
  contents <- readFile $ "day-7-input.txt"
  let input = parseInput contents

  -- scan input ::

  -- let a = Dir { dname="a", parent=(Just fs), dirs=(fromList []), files=(fromList []) }
  -- let b = Dir { dname="b", parent=(Just a), dirs=(fromList []), files=(fromList []) }
  -- print $ root b
  print $ "Part 1: "
  print $ "Part 2: "

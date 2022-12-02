import Data.List.Split (splitOn)
import Data.Map (Map, (!))
import qualified Data.Map as Map

import Data.Typeable (typeOf)


pts = Map.fromList [
    ('X', 1),
    ('Y', 2),
    ('Z', 3)
  ]

battle_score = Map.fromList [
    ('A', Map.fromList [
        ('X', 3),
        ('Y', 6),
        ('Z', 0)
      ]),
    ('B', Map.fromList [
        ('X', 0),
        ('Y', 3),
        ('Z', 6)
      ]),
    ('C', Map.fromList [
        ('X', 6),
        ('Y', 0),
        ('Z', 3)
      ])
  ]

battle_choice = Map.fromList [
    ('A', Map.fromList [
        ('X', 'Z'),
        ('Y', 'X'),
        ('Z', 'Y')
      ]),
    ('B', Map.fromList [
        ('X', 'X'),
        ('Y', 'Y'),
        ('Z', 'Z')
      ]),
    ('C', Map.fromList [
        ('X', 'Y'),
        ('Y', 'Z'),
        ('Z', 'X')
      ])
  ]

result_pts = Map.fromList [
    ('X', 0),
    ('Y', 3),
    ('Z', 6)
  ]

filterEmptyString :: [String] -> [String]
filterEmptyString = filter ((> 0) . length)

parseInput :: String -> [[Char]]
parseInput = filterEmptyString . splitOn "\n"

processWith :: ([Char] -> Integer) -> [[Char]] -> Integer
processWith f = foldl (\ total dat -> total + f dat) 0

weaponChoice (opponentChoice:' ':yourChoice:[]) = pts ! yourChoice + battle_score ! opponentChoice ! yourChoice

outcomeChoice (opponentChoice:' ':desiredOutcome:[]) = pts ! (battle_choice ! opponentChoice ! desiredOutcome) + result_pts ! desiredOutcome

main = do
  contents <- readFile $ "day-2-input.txt"
  let input = parseInput contents

  let result1 = processWith weaponChoice input
  print $ "Part 1: " ++ show (result1)

  let result2 = processWith outcomeChoice input
  print $ "Part 2: " ++ show (result2)

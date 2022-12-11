import Flow
import Data.List (isPrefixOf, stripPrefix)
import Data.List.Split (splitOn)
import Data.Map (Map, fromList, (!))
import Debug.Trace (trace)

filterEmptyString :: [String] -> [String]
filterEmptyString = filter ((> 0) . length)

data Command = Noop | AddX Integer deriving (Show)
data ExecResult = ExecResult { clock :: Integer
                             , x :: Integer
                             } deriving (Show)

addXPrefix = "addx "

parseAddX :: String -> Command
parseAddX s = AddX (read s'') where
  s' = stripPrefix addXPrefix s
  s'' = case s' of
    Just v  -> v
    Nothing -> error "wut?"

parseCommand :: String -> Command
parseCommand s
  | isPrefixOf addXPrefix s = parseAddX s
  | True = Noop

parseInput :: String -> [[Char]]
parseInput = filterEmptyString . splitOn "\n"

exec :: Command -> ExecResult -> ExecResult
exec (Noop) (ExecResult {x=x, clock=clock}) = ExecResult {x=x, clock=clock+1}
exec (AddX dx) (ExecResult {x=x, clock=clock}) = ExecResult {x=x+dx, clock=clock+2}

atClock :: Integer -> [ExecResult] -> ExecResult
atClock c = head . reverse . takeWhile (\(ExecResult {clock=clock}) -> clock < c)

pixelAt :: Integer -> [ExecResult] -> Char
-- pixelAt c results = trace (show (c, output, c', m, n, "x: " ++ (show x), aligned)) $ output
pixelAt c results = output
            where
  ExecResult { x=x, clock=clock} = atClock c results
  c' = (mod c 40) - 1
  m = (mod (x-1) 40)
  m' = (mod x 40)
  n = (mod (x+1) 40) -- assuming that the sprit will never wrap to the next line
  -- aligned = m <= c' && c' <= n
  aligned = c' == m || c' == m' || c' == n
  output = if aligned
           then '#'
           else ' '

display [] = return ()
display l = do
  putStrLn (take 40 l)
  display (drop 40 l)


main = do
  contents <- readFile "day-10-input.txt"
  let input = contents |> parseInput |> map parseCommand

  -- scan input ::
  let dat = foldl (\(lastResult:results) cmd -> (exec cmd lastResult):lastResult:results) [(ExecResult {x=1, clock=0})] input |> reverse

  print $ "Part 1: " ++ show input
  print $ "Part 1: " ++ show dat


  let y = map (\c -> (x (atClock (c) dat)) * (c)) [20,60..220]

  print $ "Part 1: " ++ show (sum y)



  let pixels = map (flip pixelAt dat) [1..240]

  print $ "Part 2: "

  -- display pixels
  display pixels

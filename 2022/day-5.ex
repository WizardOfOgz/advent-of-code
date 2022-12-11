input = File.read!("day-5-input.txt")

stacks = [
  ~c[NRGP],
  ~c[JTBLFGDC],
  ~c[MSV],
  ~c[LSRCZP],
  ~c[PSLVCWDQ],
  ~c[CTNWDMS],
  ~c[HDGWP],
  ~c[ZLPHSCMV],
  ~c[RPFLWGZ]
]

defmodule AoC do
  def parseLine(line) do
    %{"quantity" => qty, "source" => source, "dest" => dest} =
      Regex.named_captures(
        ~r/move (?<quantity>\d+) from (?<source>\d+) to (?<dest>\d+)/,
        line
      )

    [qty, source, dest] |> Enum.map(&String.to_integer/1)
  end

  def move(stacks, quantity, source, dest) do
    stacks
    # pop
    # push
  end
end

data =
  input
  |> String.trim()
  |> String.split("\n")
  |> Enum.filter(fn l -> String.starts_with?(l, "move") end)
  |> Enum.map(&AoC.parseLine/1)

IO.inspect(data)

# result1 =
#   data
#   |> Enum.filter(fn pairs -> AoC.cover(pairs) || AoC.cover(Enum.reverse(pairs)) end)
#   |> Enum.count()

# IO.inspect(result1)
# IO.puts("Part1: #{result1}")

# result2 =
#   data
#   |> Enum.filter(&AoC.overlap/1)
#   |> Enum.count()

# IO.puts("Part2: #{result2}")

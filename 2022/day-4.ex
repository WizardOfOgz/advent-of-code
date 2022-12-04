input = File.read!("day-4-input.txt")

defmodule AoC do
  def parseLine(line) do
    line
    |> String.split(",") # "1-2,3-4" -> ["1-2", "3-4"]
    |> Enum.map(fn s ->  # ["1-2", "3-4"] -> [[1, 2], [3, 4]]
      s
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def cover([[start1, end1], [start2, end2]]) do
    start1 <= start2 && start2 <= end1 && start1 <= end2 && end2 <= end1
  end

  def overlap([[start1, end1], [start2, end2]]) do
    !Range.disjoint?(start1..end1, start2..end2)
  end
end

data =
  input
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(&AoC.parseLine/1)

result1 =
  data
  |> Enum.filter(fn pairs -> AoC.cover(pairs) || AoC.cover(Enum.reverse(pairs)) end)
  |> Enum.count()

IO.inspect(result1)
IO.puts("Part1: #{result1}")

result2 =
  data
  |> Enum.filter(&AoC.overlap/1)
  |> Enum.count()

IO.puts("Part2: #{result2}")

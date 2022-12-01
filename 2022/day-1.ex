input = File.read!("day-1-input.txt")

defmodule Day1 do
  def parse_int(str, base \\ 10) do
    case Integer.parse(str, base) do
      {int, _} -> int
      _ -> raise "Failed to parse an Integer from #{str}"
    end
  end
end

elfInventories =
  input
  |> String.split("\n\n")
  |> Enum.map(fn str ->
    str
    |> String.split()
    |> Enum.map(&Day1.parse_int(&1))
  end)
  |> Enum.map(&Enum.sum(&1))
  |> Enum.sort()
  |> Enum.reverse()

IO.puts("Part1: #{List.first(elfInventories)}")

sum_top_3 =
  elfInventories
  |> Enum.take(3)
  |> Enum.sum()

IO.puts("Part2: #{sum_top_3}")

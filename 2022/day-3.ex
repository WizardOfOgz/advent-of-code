input = File.read!("day-3-input.txt")

defmodule AoC do
  def get_compartments(s) do
    String.split_at(s, div(String.length(s), 2))
  end

  def get_shared({s1, s2}) do
    MapSet.intersection(
      MapSet.new(String.to_charlist(to_string(s1))),
      MapSet.new(String.to_charlist(to_string(s2)))
    )
    |> MapSet.to_list()
  end

  def get_priority(c) do
    cond do
      c in ?a..?z -> c - ?a + 1
      c in ?A..?Z -> c - ?A + 27
    end
  end
end

data =
  input
  |> String.trim()
  |> String.split("\n")

result1 =
  data
  |> Enum.map(&AoC.get_compartments/1)
  |> Enum.flat_map(&AoC.get_shared/1)
  |> Enum.map(&AoC.get_priority/1)
  |> Enum.sum()

IO.puts("Part1: #{result1}")

result2 =
  data
  |> Enum.chunk_every(3)
  |> Enum.flat_map(fn chunk -> Enum.reduce(chunk, fn a, b -> AoC.get_shared({a, b}) end) end)
  |> Enum.map(&AoC.get_priority/1)
  |> Enum.sum()

IO.puts("Part2: #{result2}")

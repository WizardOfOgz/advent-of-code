input = File.read!("day-2-input.txt")

defmodule AoC do
  @pts %{
    X: 1,
    Y: 2,
    Z: 3
  }

  @battle_score %{
    A: %{
      X: 3,
      Y: 6,
      Z: 0
    },
    B: %{
      X: 0,
      Y: 3,
      Z: 6
    },
    C: %{
      X: 6,
      Y: 0,
      Z: 3
    }
  }

  @battle_choice %{
    A: %{
      X: :Z,
      Y: :X,
      Z: :Y
    },
    B: %{
      X: :X,
      Y: :Y,
      Z: :Z
    },
    C: %{
      X: :Y,
      Y: :Z,
      Z: :X
    }
  }

  @result_pts %{
    X: 0, # lose
    Y: 3, # draw
    Z: 6  # win
  }

  def process_with(input_data, f) do
    Enum.reduce(
      input_data,
      0,
      &(&2 + f.(&1))
    )
  end

  def weapon_choice(choices) do
    [opponent_choice, your_choice] = choices
    @pts[your_choice] + @battle_score[opponent_choice][your_choice]
  end

  def outcome_choice(choices) do
    [opponent_choice, desired_outcome] = choices
    @result_pts[desired_outcome] + @pts[@battle_choice[opponent_choice][desired_outcome]]
  end
end

data =
  input
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(fn str ->
    str
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.to_atom/1)
  end)

# IO.inspect(Enum.reverse(data))
IO.puts("Part1: #{AoC.process_with(data, &AoC.weapon_choice/1)}")
IO.puts("Part2: #{AoC.process_with(data, &AoC.outcome_choice/1)}")

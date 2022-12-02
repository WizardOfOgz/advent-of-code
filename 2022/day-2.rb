input = File.read('day-2-input.txt')

pts = {
  "X" => 1,
  "Y" => 2,
  "Z" => 3,
}

battle_score = {
  "A" => {
    "X" => 3,
    "Y" => 6,
    "Z" => 0,
  },
  "B" => {
    "X" => 0,
    "Y" => 3,
    "Z" => 6,
  },
  "C" => {
    "X" => 6,
    "Y" => 0,
    "Z" => 3,
  },
}

result = input
  .split("\n")
  .map { |line| line.split(" ") }
  .map { |opponent_choice, your_choice| pts[your_choice] + battle_score[opponent_choice][your_choice] }
  .sum

puts "Part 1: #{ result }"


battle_choice = {
  "A" => {
    "X" => "Z",
    "Y" => "X",
    "Z" => "Y",
  },
  "B" => { # paper
    "X" => "X",
    "Y" => "Y",
    "Z" => "Z",
  },
  "C" => {
    "X" => "Y",
    "Y" => "Z",
    "Z" => "X",
  },
}

result_pts = {
  "X" => 0,  # lose
  "Y" => 3,  # draw
  "Z" => 6,  # win
}

result2 = input
  .split("\n")
  .map { |line| line.split(" ") }
  .map do |opponent_choice, desired_result|
    choice = battle_choice[opponent_choice][desired_result]
    pts[choice] + result_pts[desired_result]
  end
  .sum

puts "Part 2: #{ result2 }"

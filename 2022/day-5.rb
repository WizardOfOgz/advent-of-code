input = File.read('day-5-input.txt').split("\n")

stacks = [
  %w[N R G P],
  %w[J T B L F G D C],
  %w[M S V],
  %w[L S R C Z P],
  %w[P S L V C W D Q],
  %w[C T N W D M S],
  %w[H D G W P],
  %w[Z L P H S C M V],
  %w[R P F L W G Z],
]

data = input.grep /\Amove/

result1 = data.each do |l|
  match_data = l.match /move (?<quantity>\d+) from (?<source>\d+) to (?<dest>\d+)/
  quantity = match_data[:quantity].to_i
  dest = match_data[:dest].to_i - 1
  source = match_data[:source].to_i - 1
  quantity.times do
    stacks[dest].push stacks[source].pop
  end
end

puts "Part 1: #{ stacks.map(&:last).join }"


stacks = [
  %w[N R G P],
  %w[J T B L F G D C],
  %w[M S V],
  %w[L S R C Z P],
  %w[P S L V C W D Q],
  %w[C T N W D M S],
  %w[H D G W P],
  %w[Z L P H S C M V],
  %w[R P F L W G Z],
]

data = input.grep /\Amove/

data.each do |l|
  match_data = l.match /move (?<quantity>\d+) from (?<source>\d+) to (?<dest>\d+)/
  quantity = match_data[:quantity].to_i
  dest = match_data[:dest].to_i - 1
  source = match_data[:source].to_i - 1

  s = []
  quantity.times do
    s.unshift stacks[source].pop
  end

  quantity.times do
    stacks[dest].push s.shift
  end
end

puts "Part 2: #{ stacks.map(&:last).join }"

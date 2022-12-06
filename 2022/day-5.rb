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

data.each do |l|
  l
    .match(/move (?<quantity>\d+) from (?<source>\d+) to (?<dest>\d+)/)
    .named_captures
    .transform_keys(&:to_sym)
    .transform_values(&:to_i) => { quantity: quantity, dest: dest, source: source }

  quantity.times do
    stacks[dest-1].push stacks[source-1].pop
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

data.each do |l|
  l
    .match(/move (?<quantity>\d+) from (?<source>\d+) to (?<dest>\d+)/)
    .named_captures
    .transform_keys(&:to_sym)
    .transform_values(&:to_i) => { quantity: quantity, dest: dest, source: source }

  s = []
  quantity.times do
    s.unshift stacks[source-1].pop
  end

  quantity.times do
    stacks[dest-1].push s.shift
  end
end

puts "Part 2: #{ stacks.map(&:last).join }"

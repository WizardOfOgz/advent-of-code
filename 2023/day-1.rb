input = File.read("#{File.basename(__FILE__, '.rb')}-input.txt")

lines = input.split("\n")

### Part 1
puts lines.lazy
  .map { |l| l.scan(/\d/) }
  .map { |digits| digits.first.to_i * 10 + digits.last.to_i }
  .sum

lemap = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9,
}

### Part 2
puts lines.lazy
  .map { |l| l.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).map {|(d)| lemap[d] || d.to_i } }
  .map { |digits| digits.first * 10 + digits.last }
  .sum

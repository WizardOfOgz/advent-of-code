input = File.read('day-6-input.txt').chars

_, idx = input
  .each_cons(4)
  .with_index
  .find do |chars, i|
    chars.uniq.length == 4
  end

puts "Part 1: #{ idx + 4 }"


_, idx = input
  .each_cons(14)
  .with_index
  .find do |chars, i|
    chars.uniq.length == 14
  end

puts "Part 2: #{ idx + 14 }"

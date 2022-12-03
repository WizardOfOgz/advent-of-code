input = File.read('day-3-input.txt').split("\n")

def get_priority(c)
  if c =~ /[A-Z]/
    (c.ord - "A".ord) + 27
  else
    (c.ord - "a".ord) + 1
  end
end

result1 = input.inject(0) do |total, line|
  compartment_1 = line[0...line.length/2]
  compartment_2 = line[line.length/2..-1]

  shared = compartment_1.chars & compartment_2.chars
  priority = shared.map { |c| get_priority(c) }.sum
  total + priority
end

puts "Part 1: #{ result1 }"

result2 = input.each_slice(3).inject(0) do |total, (a,b,c)|
  shared = a.chars & b.chars & c.chars
  priority = shared.map { |c| get_priority(c) }.sum
  total + priority
end

puts "Part 2: #{ result2 }"

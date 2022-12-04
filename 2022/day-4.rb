input = File.read('day-4-input.txt').split("\n")


result1 = input.select do |l|
  r1, r2 = l.split(",")
  start1, end1 = r1.split("-").map(&:to_i)
  start2, end2 = r2.split("-").map(&:to_i)

  (start1..end1).cover?(start2..end2) || (start2..end2).cover?(start1..end1)
end

puts "Part 1: #{ result1.length }"

result2 = input.select do |l|
  r1, r2 = l.split(",")
  start1, end1 = r1.split("-").map(&:to_i)
  start2, end2 = r2.split("-").map(&:to_i)

  (start1..end1).include?(start2) || (start1..end1).include?(end2) || (start2..end2).include?(start1) || (start2..end2).include?(end1)
end
# puts result2
puts "Part 2: #{ result2.length }"

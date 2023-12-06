input = File.read("#{File.basename(__FILE__, '.rb')}-input.txt")
# input = <<~INPUT
#   467..114..
#   ...*......
#   ..35..633.
#   ......#...
#   617*......
#   .....+.58.
#   ..592.....
#   ......755.
#   ...$.*....
#   .664.598..
# INPUT

lines = input.split("\n")

symbol_locations = [] # Hash.new { |h, k| h[k] = {} }

lines.each_with_index do |l, y|
  l.scan(/[^\d.]/) do |n|
    # symbol_locations[$`.size][y] = true
    symbol_locations << [$`.size, y, n]
  end
end

number_locations = []

e = Enumerator.new do |yielder|
  lines.each_with_index do |l, y|
    l.scan(/\d+/) do |n|
      y_range = (y-1..y+1)
      x_range = ($`.size-1..$`.size+n.size)

      number_locations << { n: n.to_i, x_range:, y_range: }

      # puts "> #{n} #{x_range} #{y_range}"


      isHit = symbol_locations.any? do |x, y|
        x_range.include?(x) && y_range.include?(y)
      end

      yielder << n.to_i if isHit
    end
  end
end

### Part 1
puts e.sum

r = symbol_locations.lazy
  .select { |x, y, n| n == ?* }
  .map do |x, y|
    number_locations
      .select do |nl|
        nl => { n:, x_range:, y_range: }
        x_range.include?(x) && y_range.include?(y)
      end
      .map { |nl| nl[:n] }
  end
  .select { |nls| nls.count == 2 }
  .map { |nls| nls.reduce(&:*) }
  .sum
### Part 2
puts r

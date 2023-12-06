input = File.read("#{File.basename(__FILE__, '.rb')}-input.txt")
# input = <<~INPUT
#   Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
#   Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
#   Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
#   Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
#   Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
#   Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
# INPUT

lines = input.split("\n")

r = lines
  .map do |l|
    l
      .split(/[:|]/)[1..2]
      .map do |s|
        s.scan(/\d+/).map(&:to_i)
      end
      .reduce(&:&)
  end
  .tap {|c| puts c.inspect }
  .reject(&:empty?)
  .map { |n| 2 ** (n.size - 1) }
  .sum

### Part 1
puts "Part 1: #{r}"

cards = lines.map { 1 }

lines
  .each_with_index do |l, idx|
    num_matches = l
      .split(/[:|]/)[1..2]
      .map do |s|
        s.scan(/\d+/).map(&:to_i)
      end
      .reduce(&:&)
      .size

    # puts "#{idx}: #{ num_matches } * #{ cards[idx] } = #{ num_card_matches }"
    num_matches.times do |i|
      cidx = idx + i + 1
      next if cidx > cards.length - 1
      cards[cidx] += cards[idx]
    end
    # puts "> #{cards.inspect}"
  end

### Part 2
puts "Part 2: #{cards.sum}"

input = File.read('day-1-input.txt')

elf_invetories = input.split("\n\n")

totals_by_elf = elf_invetories.map do |inventory|
  inventory.split("\n").map(&:to_i).sum
end

puts "Part 1: #{ totals_by_elf.max }"
puts "Part 2: #{ totals_by_elf.sort[-3..-1].sum }"

input = File.read('day-8-input.txt').split("\n")

grid = input.map {|l| l.chars.map(&:to_i)}



# grid = [
#   [3,0,3,7,3],
#   [2,5,5,1,2],
#   [6,5,3,3,2],
#   [3,3,5,4,9],
#   [3,5,3,9,0],
# ]

vis = Array.new(grid.length) { Array.new(grid.first.length) { false }}

grid.length.times do |i|
  prev = nil

  grid.first.length.times do |j|

    if prev.nil? || grid[i][j] > prev
      vis[i][j] = true
      prev = grid[i][j]
    end
  end
end

grid.length.times do |i|
  prev = nil

  max_j = grid.first.length-1
  (max_j..0).step(-1).each do |j|
    # puts "> #{[i,j,prev]}"

    if prev.nil? || grid[i][j] > prev
      vis[i][j] = true
      prev = grid[i][j]
    end
  end
end

grid.first.length.times do |j|
  prev = nil

  grid.length.times do |i|
    if prev.nil? || grid[i][j] > prev
      vis[i][j] = true
      prev = grid[i][j]
    end
  end
end

grid.first.length.times do |j|
  prev = nil

  max_i = grid.length-1
  (max_i..0).step(-1).each do |i|
    # puts "> #{[i,j,prev]}"
    if prev.nil? || grid[i][j] > prev
      # puts "-"
      vis[i][j] = true
      prev = grid[i][j]
    end
  end
end

result1 = vis.map {|l| l.count(&:itself) }.sum
# vis.each {|l| puts l.inspect }
# result1 = vis

# puts vis.length
# puts grid.length
puts "Part 1: #{ result1 }"


# grid = [
#   [3,0,3,7,3],
#   [2,5,5,1,2],
#   [6,5,3,3,2],
#   [3,3,5,4,9],
#   [3,5,3,9,0],
# ]

# pp grid

def score(grid, i,j, di = 0, dj = 0)
  target = grid[i][j]


  r = [
    grid[i][0...j].reverse.tap { @prev = nil }.take_while {|t| puts @prev; r = (@prev.nil? || @prev < target); @prev = t; r },
    grid[i][j+1...grid.first.length].tap { @prev = nil }.take_while {|t| puts @prev; r = (@prev.nil? || @prev < target); @prev = t; r },
    (0...i).to_a.map {|ii| grid[ii][j] }.reverse.tap { @prev = nil }.take_while {|t| puts @prev; r = (@prev.nil? || @prev < target); @prev = t; r },
    (i+1...grid.length).to_a.map {|ii| grid[ii][j] }.tap { @prev = nil }.take_while {|t| puts @prev; r = (@prev.nil? || @prev < target); @prev = t; r },
  ]

  puts r.inspect
  r.map(&:count).inject(&:*)
end

# puts score(grid, 3,2)


@max = 0
grid.length.times do |i|
  grid.first.length.times do |j|
    s = score(grid, i, j)
    @max = s if s > @max
  end
end


result2 = @max
puts "Part 2: #{ result2 }"

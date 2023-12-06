input = File.read("#{File.basename(__FILE__, '.rb')}-input.txt")
# input = <<~INPUT
#   Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
#   Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
#   Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
#   Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
#   Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
# INPUT

lines = input.split("\n")

games = lines.lazy
  .reduce({}) do |r, l|
    id = l.match(/Game (?<id>\d+):/)[:id].to_i
    raw_sets = l.split(?;)
    r.merge(id => raw_sets)
  end
  .transform_values do |raw_sets|
    raw_sets.map do |set|
      set.scan(/(?<quantity>\d+)\s+(?<color>\w*)/).inject({}) do |r, (q, color)|
        r.merge(color => q.to_i)
      end
      .transform_keys(&:to_sym)
    end
  end



def valid_games(g, opts = {})
  vg = g.select do |id, sets|
    # puts "Game #{id}:"
    sets.all? do |set|
      opts.all? do |color, max|
        # puts "(#{color}, #{max}): #{set[color]} = #{set[color].nil?} || #{!set[color].nil? && set[color] <= max} (#{set[color].nil? || set[color] <= max})"
        set[color].nil? || set[color] <= max
      end
    end
  end
end

puts games.to_a.inspect

ggs = valid_games(games, red: 12, green: 13, blue: 14)

puts "VG", ggs.keys.inspect

### Part 1
puts "Sum: #{ggs.keys.sum}"


powers = games.map do |id, sets|
  min_cubes = sets.reduce do |res, s|
    res.merge(s) { |_, *values| values.max } # aggregate the max value for each color
  end
  min_cubes.values.reduce(&:*)
end
### Part 2
puts powers.sum

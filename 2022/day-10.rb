def parse(l)
  if l.start_with?("addx")
    [2, l.sub("addx ", "").to_i]
  else
    [1]
  end
end

input = File.read('day-10-input.txt')
  .split("\n")
  .map {|l| parse l }




test = DATA.map {|l| parse l }

def preprocess(cmds)
  cmds.inject([[0, 1]]) do |r, cmd|
    r << [r.last.first + cmd.first, r.last[1] + cmd[1].to_i, *cmd]
    r
  end
end

def p(cmds)
  (20..220).step(40).map do |cycle|
    x = cmds.take_while {|cmd| cmd.first < cycle}.last
    x[1] * cycle
  end
end



result1 = preprocess input
puts "Part 1: #{ p(result1).sum }"


def at_cycle(cycle, cmds)
  x = cmds.take_while {|cmd| cmd.first < cycle}.last

  sprite_pos = x[1]
  r = (sprite_pos-1..sprite_pos+1).include?((cycle % 40) - 1) ? '@' : ' '

  # puts "cycle #{cycle.to_s.rjust(3, ' ')} #{r} pos: #{sprite_pos}  #{x}"
  r
end



cmds = preprocess input
pixels = (1..240).map {|cycle| at_cycle(cycle, cmds) }
# puts "Part 2: #{ pixels }"

pixels.each_slice(40) do |l|
  puts l.join
end


__END__
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop

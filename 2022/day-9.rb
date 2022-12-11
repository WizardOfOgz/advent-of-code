require 'set'

input = File.read('day-9-input.txt')
  .split("\n")
  .map do |l|
    dir, count = l.split(" ")
    [dir, count.to_i]
  end


head = [0,0]
tail = [0,0]


test = [
  [?R, 4],
  [?U, 4],
  [?L, 3],
  [?D, 1],
  [?R, 4],
  [?D, 1],
  [?L, 5],
  [?R, 2],
]


def move(dir, h, t)
  new_h = case dir
  when 'R' then
    [h[0] + 1, h[1]]
  when 'L' then
    [h[0] - 1, h[1]]
  when 'U' then
    [h[0], h[1]+1]
  when 'D' then
    [h[0], h[1]-1]
  end

  new_t =
    if (new_h[0] - t[0]).abs > 1 || (new_h[1] - t[1]).abs > 1
      new_t = h
    else
      t
    end

  [new_h, new_t]
end

t_positions = Set.new

# input.each do |dir, count|
#   puts "-> #{ dir } #{count}"
#   count.times do
#     head, tail = move dir, head, tail
#     # log t
#     puts [head, tail].inspect
#     t_positions.add tail
#   end
# end




# result1 = t_positions.length
# puts "Part 1: #{ result1 }"










knots = [
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
  [0,0],
]


test = [
  [?R, 5],
  [?U, 8],
  [?L, 8],
  [?D, 3],
  [?R, 17],
  [?D, 10],
  [?L, 25],
  [?U, 20],
]

t_positions = Set.new



def move(dir, h)
  puts "move #{dir} #{h.inspect}"
  new_h = case dir
  when 'R' then
    [h[0] + 1, h[1]]
  when 'L' then
    [h[0] - 1, h[1]]
  when 'U' then
    [h[0], h[1]+1]
  when 'D' then
    [h[0], h[1]-1]
  end

  # follow(new_h, t, h)
  new_h
end
def follow(h, t)
  puts "follow #{[h,t].inspect}"
  new_t = t.dup

  # if (h[0] - t[0]).abs > 1
  #   new_t = [t[0] + ((h[0] - t[0])/(h[0] - t[0]).abs), h[1]]
  # end
  # if (h[1] - t[1]).abs > 1
  #   new_t = [h[0], t[1] + ((h[1] - t[1])/(h[1] - t[1]).abs)]
  # end

  if (h[0] - t[0]).abs > 1 || (h[1] - t[1]).abs > 1
    new_t = [t[0] + ((h[0] - t[0])/[(h[0] - t[0]).abs,1].max), t[1] + ((h[1] - t[1])/[(h[1] - t[1]).abs,1].max)]
  end


  # [h, new_t]
  new_t
end

input.each do |dir, count|
  puts "-> #{ dir } #{count}"
  count.times do
    # puts "--------"
    knots[0] = move(dir, knots[0])
    (1...knots.length).each do |idx|
    # knots.each_cons(2).with_index do |(original_h, original_t), idx|
      # original_h = knots[idx]
      t = follow(knots[idx-1], knots[idx])
      puts "IDX #{idx} #{t.inspect}"
#     puts [head, tail].inspect

      # log t
      knots[idx] = t
      # knots[idx+1] = t

    end
    # puts [head, tail].inspect


    t_positions.add knots.last
    knots.each_with_index {|k,idx| puts "#{idx} #{k.inspect}" }
  end
end




result2 = t_positions.length
puts "Part 2: #{ result2 }"

# puts t_positions

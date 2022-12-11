input = File.read('day-7-input.txt').split("\n")

def new_dir(name)
  {name: name, files: Hash.new { |h,k| h[k] = {name: k} }, dirs: Hash.new { |h,k| h[k] = new_dir(k) }}
end

def size(dir)
  dir[:files].map { |_,f| f[:size] }.sum + dir[:dirs].map { |_,d| size(d) }.sum
end

@ds = []
def t(dir)
  if size(dir) <= 100_000
    @ds.push dir
  end
  dir[:dirs].each { |_,d| t(d) }
end

root = new_dir("/")
dir_stack = [root]

input.each do |l|
  if l == '$ ls'

  elsif l.start_with?('$ cd')
    dir = l[/\$ cd (?<dir>\S+)/, :dir]
    if dir == '/'
      dir_stack = [root]
    elsif dir == '..'
      dir_stack.pop
    else
      d = dir_stack.last[:dirs][dir]
      dir_stack.push d
    end
  elsif l =~ /\d+/
    l
      .match(/\A(?<size>\d+) (?<file>\S+)$/)
      .named_captures
      .transform_keys(&:to_sym) => { size: size, file: file }
    dir_stack.last[:files][file][:size] = size.to_i
  end
end

t(root)
puts "Part 1 #{ @ds.map {|d| size(d) }.sum }"

free = 70000000 - size(root)
target = 30000000 - free

@ts = []
def ts(dir)
  @ts.push dir
  dir[:dirs].each { |_,d| ts(d) }
end
ts(root)

puts @ts.map {|d| size(d)}.sort.inspect
puts "Part 2: #{ @ts.map {|d| size(d)}.sort.find {|i| i >= target } }"


# def prd(dir, l = 0)
#   puts " "*l*2 + "- #{dir[:name]} #{size(dir)}"
#   dir[:files].each do |f,d|
#     puts " "*(l*2+2) + "• #{f} #{d[:size]}"
#   end
#   dir[:dirs].each { |_,d| prd(d, l+1) }
# end
# prd root

LITERS = 150

containers = DATA.each_line.map(&:to_i)
ways = [0] * containers.size

containers.size.times do |n|
  containers.combination(n).each do |c|
    ways[c.size] += 1 if c.sum == LITERS
  end
end

p ways.sum
p ways.find(&:positive?)

__END__
33
14
18
20
45
35
16
35
1
13
18
13
50
44
48
6
24
41
30
42

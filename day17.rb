containers = File.readlines("day17.input").map(&:to_i)
ways = Array.new(containers.size, 0)

containers.size.times do |n|
  containers.combination(n).each do |c|
    ways[c.size] += 1 if c.reduce(:+) == 150
  end
end

p ways.reduce(:+)
p ways.find { |w| w > 0 }

distance = 2503
reindeers = {}

File.readlines("14.input").each do |line|
  name, speed, duration, rest = line.scan(/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds/).flatten
  reindeers[name] = Array.new(duration.to_i, speed.to_i) + Array.new(rest.to_i, 0)
  reindeers[name] *= (distance / reindeers[name].size) + 1
end

# part 1
p reindeers.values.map { |r| r[0...distance].reduce(:+) }.max

# part 2
lead = 0
points = Hash.new(0)
distance.times do |d|
  reindeers.values.map { |r| r[d] += r[d - 1] } if d > 0
  lead = reindeers.values.map { |r| r[d] }.max
  reindeers.keys.each { |r| points[r] += 1 if reindeers[r][d] == lead }
end

p points.values.max

require "set"

cities = Set.new
@distances = {}

def compute_distance(path)
  distance = 0
  path.each_cons(2) { |s| distance += @distances[s[0]][s[1]] }
  distance
end

routes = File.readlines("09.input")
routes.each do |route|
  source, destination, distance = route.scan(/(\w+) to (\w+) = (\d+)/).flatten
  distance = distance.to_i
  cities << source
  cities << destination
  @distances[source] ||= {}
  @distances[source][destination] = distance
  @distances[destination] ||= {}
  @distances[destination][source] = distance
end

maximum = 0
minimum = 1_000_000

cities.to_a.permutation.each do |path|
  distance = compute_distance(path)
  minimum = distance if distance < minimum
  maximum = distance if distance > maximum
end

puts "MINIMUM: #{minimum}, MAXIMUM: #{maximum}"

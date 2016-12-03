triangles = 0

input = File.readlines("day03.input")

input.map { |l| l.split.map(&:to_i) }
     .transpose # remove for part 1
     .flatten
     .each_slice(3) do |t|
  a, b, c = t
  triangles += 1 if (a + b > c) && (b + c > a) && (a + c > b)
end

puts triangles

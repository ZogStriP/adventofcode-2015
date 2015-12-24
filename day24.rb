@weights = File.readlines("day24.input").map(&:to_i)

def min_quantum(groups)
  sum = @weights.reduce(:+) / groups
  (1..@weights.size).each do |s|
    w = @weights.combination(s).select { |c| c.reduce(:+) == sum }
    return w.map { |c| c.reduce(:*) }.min if w.size > 0
  end
end

p min_quantum(3)
p min_quantum(4)

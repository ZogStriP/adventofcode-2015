max = 0

(0..100).each do |a|
  (0..(100 - a)).each do |b|
    (0..(100 - a - b)).each do |c|
      (0..(100 - a - b - c)).each do |d|
        next unless a + b + c + d == 100
        # uncomment for part 2
        # next unless (5 * a) + b + (6 * c) + (8 * d) == 500
        capacity = (5 * a) + (-1 * b) + (-1 * d)
        durability = (-1 * a) + (3 * b) + (-1 * c)
        flavor = (4 * c)
        texture = (2 * d)
        cookie = [0, capacity].max * [0, durability].max * [0, flavor].max * [0, texture].max
        max = cookie if cookie > max
      end
    end
  end
end

p max

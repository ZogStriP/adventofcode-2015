input = DATA.read.delete("\n").freeze
grid = input.tr(".#", "01").reverse.to_i(2)
seen = {}

until seen[grid]
  seen[grid] = true
  g = 0

  25.times { |i|
    c = 0
    c += (grid >> (i - 5)) & 1 if i >= 5
    c += (grid >> (i + 5)) & 1 if i < 20
    c += (grid >> (i - 1)) & 1 if i % 5 != 0
    c += (grid >> (i + 1)) & 1 if i % 5 != 4
    g |= 1 << i if c == 1 || (c == 2 && ((grid >> i) & 1) == 0)
  }

  grid = g
end

p grid

NEIGHBORS = [
  [[7, -1], [1, 0], [5, 0], [11, -1]],
  [[7, -1], [2, 0], [6, 0], [0, 0]],
  [[7, -1], [3, 0], [7, 0], [1, 0]],
  [[7, -1], [4, 0], [8, 0], [2, 0]],
  [[7, -1], [13, -1], [9, 0], [3, 0]],
  [[0, 0], [6, 0], [10, 0], [11, -1]],
  [[1, 0], [7, 0], [11, 0], [5, 0]],
  [[2, 0], [8, 0], [0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [6, 0]],
  [[3, 0], [9, 0], [13, 0], [7, 0]],
  [[4, 0], [13, -1], [14, 0], [8, 0]],
  [[5, 0], [11, 0], [15, 0], [11, -1]],
  [[6, 0], [0, 1], [5, 1], [10, 1], [15, 1], [20, 1], [16, 0], [10, 0]],
  [], # center
  [[8, 0], [14, 0], [18, 0], [4, 1], [9, 1], [14, 1], [19, 1], [24, 1]],
  [[9, 0], [13, -1], [19, 0], [13, 0]],
  [[10, 0], [16, 0], [20, 0], [11, -1]],
  [[11, 0], [17, 0], [21, 0], [15, 0]],
  [[20, 1], [21, 1], [22, 1], [23, 1], [24, 1], [18, 0], [22, 0], [16, 0]],
  [[13, 0], [19, 0], [23, 0], [17, 0]],
  [[14, 0], [13, -1], [24, 0], [18, 0]],
  [[15, 0], [21, 0], [17, -1], [11, -1]],
  [[16, 0], [22, 0], [17, -1], [20, 0]],
  [[17, 0], [23, 0], [17, -1], [21, 0]],
  [[18, 0], [24, 0], [17, -1], [22, 0]],
  [[19, 0], [13, -1], [17, -1], [23, 0]],
]

def evolve(grids)
  g = Hash.new { |h, k| h[k] = ?. * 25 }

  min, max = grids.keys.minmax

  Range.new(min - 1, max + 1).each { |k|
    25.times { |i|
      c = NEIGHBORS[i].count { |n, l| grids[k + l][n] == ?# }
      g[k][i] = ?# if c == 1 || (c == 2 && grids[k][i] == ?.)
    }
  }

  g
end

grids = Hash.new { |h, k| h[k] = ?. * 25 }
grids[0] = input

200.times { grids = evolve(grids) }

p grids.values.sum { |g| g.count(?#) }

__END__
#..##
#.#..
#...#
##..#
#..##
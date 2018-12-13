tracks = IO.read("13.input").split("\n").map(&:chars)

fail "invalid input" unless tracks.map(&:size).uniq.size == 1

carts = []

DIRECTIONS = [
  [-1,  0], # up
  [ 0,  1], # right
  [ 1,  0], # down
  [ 0, -1], # left
]

CARTS = ["^", ">", "v", "<"]
CURVE_RIGHT = [1, 0, 3, 2]
CURVE_LEFT  = [3, 2, 1, 0]

tracks.each_with_index { |r, y|
  r.each_with_index { |c, x|
    if c["^"]
      carts << [y, x, 0, 0]
      r[x] = "|"
    elsif c["v"]
      carts << [y, x, 2, 0]
      r[x] = "|"
    elsif c["<"]
      carts << [y, x, 3, 0]
      r[x] = "-"
    elsif c[">"]
      carts << [y, x, 1, 0]
      r[x] = "-"
    end
  }
}

crashed_carts = []

while carts.size > 1
  carts.sort_by { |c| c[0, 2] }.each { |c|
    d = DIRECTIONS[c[2]]
    n = [c[0] + d[0], c[1] + d[1]]
    t = tracks[n[0]][n[1]]

    if cc = carts.find { |cc| n == cc[0, 2] }
      crashed_carts << carts.delete(c) << carts.delete(cc)
    elsif t["/"]
      c[2] = CURVE_RIGHT[c[2]]
    elsif t["\\"]
      c[2] = CURVE_LEFT[c[2]]
    elsif t["+"]
      if c[3] == 0 # left
        c[2] = (c[2] - 1) % 4
      elsif c[3] == 2 # right
        c[2] = (c[2] + 1) % 4
      end
      c[3] = (c[3] + 1) % 3
    end

    c[0, 2] = n
  }
end

p crashed_carts[0][0, 2].reverse
p carts[0][0, 2].reverse

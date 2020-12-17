ddd, dddd = {}, {}

DATA.each_line.with_index { |l, y|
  l.each_char.with_index { |c, x|
    ddd[[x, y, 0]] = true if c[?#]
    dddd[[x, y, 0, 0]] = true if c[?#]
  }
}

@diffs = []

def neighbors(c)
  @diffs[c.size] ||= [-1, 0, 1].repeated_permutation(c.size).to_a - [[0] * c.size]
  @diffs[c.size].each { |d| yield c.zip(d).map(&:sum) }
end

6.times {
  counts, _copy = Hash.new(0), {}
  ddd.each_key { |c| neighbors(c) { |n| counts[n] += 1 } }
  counts.each { |c, n| _copy[c] = true if (ddd[c] && n == 2) || n == 3 }
  ddd = _copy
}

p ddd.size

6.times {
  counts, _copy = Hash.new(0), {}
  dddd.each_key { |c| neighbors(c) { |n| counts[n] += 1 } }
  counts.each { |c, n| _copy[c] = true if (dddd[c] && n == 2) || n == 3 }
  dddd = _copy
}

p dddd.size

__END__
#.#..#.#
#.......
####..#.
.#.#.##.
..#..#..
###..##.
.#..##.#
.....#..

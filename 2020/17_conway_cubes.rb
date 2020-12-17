init = {}

DATA.each_line.with_index { |l, y|
  l.each_char.with_index { |c, x|
    init[[x, y]] = true if c[?#]
  }
}

@diffs = []

def neighbors(c)
  @diffs[c.size] ||= [-1, 0, 1].repeated_permutation(c.size).to_a - [[0] * c.size]
  @diffs[c.size].each { |d| yield c.zip(d).map(&:sum) }
end

[3, 4].each { |d|
  space = init.transform_keys { |c| c + [0] * (d - 2) }

  6.times {
    counts, _copy = Hash.new(0), {}
    space.each_key { |c| neighbors(c) { |n| counts[n] += 1 } }
    counts.each { |c, n| _copy[c] = true if (space[c] && n == 2) || n == 3 }
    space = _copy
  }

  p space.size
}

__END__
#.#..#.#
#.......
####..#.
.#.#.##.
..#..#..
###..##.
.#..##.#
.....#..

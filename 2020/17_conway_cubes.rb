init = {}

DATA.each_line.with_index { |l, y|
  l.each_char.with_index { |c, x|
    init[[x, y]] = true if c[?#]
  }
}

[3, 4].each { |dim|
  space = init.transform_keys { |c| c + [0] * (dim - 2) }
  diffs = [-1, 0, 1].repeated_permutation(dim).to_a - [[0] * dim]

  6.times {
    counts, _copy = Hash.new(0), {}
    space.each_key { |c| diffs.each { |d| counts[c.zip(d).map(&:sum)] += 1 } }
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

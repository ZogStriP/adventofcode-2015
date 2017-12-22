input = DATA.readlines.map { |l| l.strip.chars }

grid = Hash.new { :clean }

input.each_with_index { |line, y|
  line.each_with_index { |c, x|
    grid[[x, y]] = :infected if c["#"]
  }
}

def infect(grid, start, bursts, states)
   x,  y = start
  dx, dy = [0, -1]
  count  = 0

  n = states.zip(states.rotate(1)).to_h

  bursts.times {
    p = [x, y]
    g = grid[p]

    if g == :clean
      dx, dy = dy, -dx
    elsif g == :infected
      dx, dy = -dy, dx
    elsif g == :flagged
      dx, dy = -dx, -dy
    end

    count += 1 if (grid[p] = n[g]) == :infected

    x += dx
    y += dy
  }

  count
end

x = input[0].size / 2
y = input.size / 2

p infect(grid.dup, [x, y], 10_000, %i{clean infected})
p infect(grid.dup, [x, y], 10_000_000, %i{clean weakened infected flagged})

__END__
##########..#.###...##..#
##....#...#....#..####.#.
#..#.##..#..##.###..#.###
.#.#.......####.....#.#..
...######....#.##########
##.#.....#.#####.#....###
#.####.#..#.#.#...#.#..##
#.##..#####..###..###.##.
#.####.#.##.##...#.#.#.##
#.#.#......##.##..###.#.#
#...#.#..#.##....#.##..##
.#.....##.##..#.####..##.
.#......#.#.########..###
##....###.#.#.###...##..#
..##.###....#.....#...#.#
....##...##...##.##.#..##
..#.#.#..#######..###..##
......#####.#####..#.#..#
.####.#......#..###..#.##
#....####.#..#.##.###.##.
####.#...##....###...#.#.
#####.#......#.#..###.##.
#.##.#..#..#..#.....#.#.#
#...#.#.##.#.####.#.#..#.
.##.##..#..###.##.....###

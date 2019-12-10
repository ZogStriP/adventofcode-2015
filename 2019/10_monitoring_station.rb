require "set"

map = DATA.read.split("\n").map(&:chars)

@width  = map.size
@height = map[0].size
@field  = Set.new

map.each.with_index { |r, y|
  r.each.with_index { |c, x|
    @field << [x, y] if c == ?#
  }
}

def first_asteroid(from, dx, dy)
  x, y = from

  loop {
    x += dx
    y += dy
    return [x, y] if @field.include?([x, y])
    return if x < 0 || x >= @width || y < 0 || y >= @height
  }
end

def can_see?(a, b)
  dx = b[0] - a[0]
  dy = b[1] - a[1]
  g = dy.gcd(dx)
  dx /= g
  dy /= g

  first_asteroid(a, dx, dy) == b
end

visible = Hash.new(0)

@field.to_a
  .combination(2)
  .select { |a, b| can_see?(a, b) }
  .each { |a, b| visible[a] += 1; visible[b] += 1 }

station, count = visible.max_by(&:last)

p count

directions = []

(-@width..@width).each { |dx|
  (-@height..@height).each { |dy|
    directions << [dx, dy] if dx.gcd(dy) == 1
  }
}

count = 0

p directions.sort_by { |dx, dy| -Math.atan2(dx, dy) }.cycle { |dx, dy|
  next unless asteroid = first_asteroid(station, dx, dy)
  @field.delete(asteroid)
  break asteroid[0] * 100 + asteroid[1] if (count += 1) == 200
}

__END__
.###..#######..####..##...#
########.#.###...###.#....#
###..#...#######...#..####.
.##.#.....#....##.#.#.....#
###.#######.###..##......#.
#..###..###.##.#.#####....#
#.##..###....#####...##.##.
####.##..#...#####.#..###.#
#..#....####.####.###.#.###
#..#..#....###...#####..#..
##...####.######....#.####.
####.##...###.####..##....#
#.#..#.###.#.##.####..#...#
..##..##....#.#..##..#.#..#
##.##.#..######.#..#..####.
#.....#####.##........#####
###.#.#######..#.#.##..#..#
###...#..#.#..##.##..#####.
.##.#..#...#####.###.##.##.
...#.#.######.#####.#.####.
#..##..###...###.#.#..#.#.#
.#..#.#......#.###...###..#
#.##.#.#..#.#......#..#..##
.##.##.##.#...##.##.##.#..#
#.###.#.#...##..#####.###.#
#.####.#..#.#.##.######.#..
.#.#####.##...#...#.##...#.

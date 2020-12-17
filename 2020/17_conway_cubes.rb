DIRS = [-1, 0, 1]

ddd, dddd = {}, {}

DATA.each_line.with_index { |l, y|
  l.each_char.with_index { |c, x|
    ddd[[x, y, 0]] = true if c[?#]
    dddd[[x, y, 0, 0]] = true if c[?#]
  }
}

def neighbors_3d(x, y, z)
  DIRS.each { |dx|
    DIRS.each { |dy|
      DIRS.each { |dz|
        next if dx == 0 && dy == 0 && dz == 0
        yield [x + dx, y + dy, z + dz]
      }
    }
  }
end

def neighbors_4d(x, y, z, a)
  DIRS.each { |dx|
    DIRS.each { |dy|
      DIRS.each { |dz|
        DIRS.each { |da|
          next if dx == 0 && dy == 0 && dz == 0 && da == 0
          yield [x + dx, y + dy, z + dz, a + da]
        }
      }
    }
  }
end

6.times {
  counts, _ddd = Hash.new(0), {}
  ddd.each_key { |c| neighbors_3d(*c) { |n| counts[n] += 1 } }
  counts.each { |c, n| _ddd[c] = true if (ddd[c] && n == 2) || n == 3 }
  ddd = _ddd
}

p ddd.size

6.times {
  counts, _dddd = Hash.new(0), {}
  dddd.each_key { |c| neighbors_4d(*c) { |n| counts[n] += 1 } }
  counts.each { |c, n| _dddd[c] = true if (dddd[c] && n == 2) || n == 3 }
  dddd = _dddd
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

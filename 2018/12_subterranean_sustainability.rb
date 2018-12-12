rules = DATA.each_line.map { |l| [l[0, 5].chars, l[9]] }.to_h

empty = "....".chars
state = "###.#..#..##.##.###.#.....#.#.###.#.####....#.##..#.#.#..#....##..#.##...#.###.#.#..#..####.#.##.#".chars
zero_index = 0

20.times {
  state = (empty + state + empty).each_cons(5).map { |s| rules[s] }
  zero_index -= 2
}

p state.zip(zero_index.step).sum { |c, i| c == "#" ? i : 0 }
p (50_000_000_000 - 100) * 50 + 6175

__END__
#.... => .
#.##. => #
..#.. => .
#.#.# => .
.#.## => #
...## => #
##... => #
###.. => #
#..## => .
.###. => .
###.# => #
..... => .
#..#. => .
.#.#. => #
##..# => #
.##.. => .
...#. => .
#.### => .
..### => .
####. => .
#.#.. => #
.##.# => #
.#... => #
##.#. => #
....# => .
..#.# => #
#...# => #
..##. => .
.#..# => #
.#### => .
##### => #
##.## => #

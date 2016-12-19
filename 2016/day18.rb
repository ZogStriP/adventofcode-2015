input = File.read("day18.input").strip.chars
max   = 2 ** input.size - 1

[40, 400000].each { |s|
  row   = input.reduce(0) { |i, c| i << 1 | (c["^"] ? 1 : 0) }
  traps = 0
  s.times {
    traps += row.to_s(2).count("1")
    row    = ((row << 1) ^ (row >> 1)) & max
  }
  p (input.size * s) - traps
}

INPUT = "760221"

scores = [3, 7]
a, b = 0, 1

16_000_000.times {
  s = scores[a] + scores[b]
  s > 9 ? scores << 1 << s - 10 : scores << s
  a = (a + scores[a] + 1) % scores.size
  b = (b + scores[b] + 1) % scores.size
}

puts scores[INPUT.to_i, 10].join

sequence = INPUT.chars.map(&:to_i)

p INPUT.to_i.step { |i|
  break i if scores[i] == sequence[0] &&
    scores[i + 1] == sequence[1] &&
    scores[i + 2] == sequence[2] &&
    scores[i + 3] == sequence[3] &&
    scores[i + 4] == sequence[4] &&
    scores[i + 5] == sequence[5]
}

INPUT = 760221

sequence = INPUT.digits.reverse

scores = [nil] * 16_000_000
scores[0] = 3
scores[1] = 7

size = 2

a = 0
b = 1

scores.size.times {
  s = scores[a] + scores[b]
  if s > 9
    scores[size] = 1; size += 1
    scores[size] = s - 10; size += 1
  else
    scores[size] = s; size += 1
  end
  a = (a + scores[a] + 1) % size
  b = (b + scores[b] + 1) % size
}

puts scores[INPUT, 10].join

p INPUT.step { |i|
  break i if scores[i] == sequence[0] &&
    scores[i + 1] == sequence[1] &&
    scores[i + 2] == sequence[2] &&
    scores[i + 3] == sequence[3] &&
    scores[i + 4] == sequence[4] &&
    scores[i + 5] == sequence[5]
}

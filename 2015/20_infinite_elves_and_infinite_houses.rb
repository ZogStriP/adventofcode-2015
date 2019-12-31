N = 29_000_000
MAX = N / 10

houses = [10] * (MAX + 1)

(2..MAX).each { |a|
  a.step(MAX, a) { |b|
    houses[b] += a * 10
  }
}

p houses.index { |h| h >= N }

houses = [11] * (MAX + 1)

(2..MAX).each { |a|
  a.step(MAX, a).first(50).each { |b|
    houses[b] += a * 11
  }
}

p houses.index { |h| h >= N }

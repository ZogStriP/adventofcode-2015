max, first, total = 0, nil, 0

File.readlines("day20.input")
    .map { |line| line.split("-").map(&:to_i) }
    .sort
    .each { |low, high|
  if max < low
    first ||= max
    total += low - max
  end
  max = high + 1 if max <= high
}

total += 2 ** 32 - max

p first, total

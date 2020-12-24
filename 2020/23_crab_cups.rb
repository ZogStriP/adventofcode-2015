def game(cups, total, rounds, result)
  after = *(1..total + 1)
  cups.each_cons(2) { after[_1] = _2 }

  if total > cups.size
    after[cups[-1]] = cups.size + 1
    after[total] = cups[0]
  else
    after[cups[-1]] = cups[0]
  end

  current = cups[0]

  rounds.times { |r|
    a = after[current]
    b = after[a]
    c = after[b]
    d = after[c]

    dest = current == 1 ? total : current - 1
    dest = dest == 1 ? total : dest - 1 while dest == a || dest == b || dest == c

    e = after[dest]

    after[current] = d
    after[dest] = a
    after[c] = e

    current = d
  }

  current = 1
  result.times.map { current = after[current] }
end

cups = 962713854.digits.reverse

puts game(cups, cups.size, 100, cups.size - 1).join
puts game(cups, 1_000_000, 10_000_000, 2).reduce(:*)

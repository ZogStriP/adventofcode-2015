i, n, card, door = 0, 1, *DATA.read.split.map(&:to_i)

(i += 1; n = (n * 7) % 20201227) while n != card

p door.pow(i, 20201227)

__END__
6930903
19716708

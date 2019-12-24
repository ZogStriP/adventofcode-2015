SHUFFLES = DATA.read.split("\n")

p = 2019
n = 10007

SHUFFLES.each { |s|
  case s
  when /deal with increment (\d+)/
    p = ( p * $1.to_i) % n
  when /cut (-?\d+)/
    p = ( p - $1.to_i) % n
  when /deal into new stack/
    p = (-p - 1) % n
  end
}

p p

# part 2 is totally stolen from https://www.reddit.com/r/adventofcode/comments/ee0rqi/2019_day_22_solutions/

p = 2020
n = 119315717514047
r = 101741582076661

# f(x) = ax + b
# g(x) = cx + d

# g(f(x))
#   = c(f(x)) + d
#   = c(ax + b) + d
#   = cax + cb + d

a = 1
b = 0

SHUFFLES.each { |s|
  case s
  when /deal with increment (\d+)/
    c = $1.to_i
    d = 0
  when /cut (-?\d+)/
    c = 1
    d = -$1.to_i
  when /deal into new stack/
    c = -1
    d = -1
  end
  a = (c * a) % n
  b = (c * b + d) % n
}

# instead of doing

# c, d = a, b
# a, b = 1, 0
#
# r.times {
#   a = (c * a) % n
#   b = (c * b + d) % n
# }

# we compute

# a = (a ** r) % n
# b = ... + a ** 2 * b + a * b + b = b * (a ** (r - 1) + a ** (r) + ... + a + 1) = b * (a ** r - 1) / (a - 1)

inv = -> (a, b) { a.pow(b - 2, b) }

aa = a.pow(r, n)
bb = (b * (aa - 1) * inv[a - 1, n]) % n

p ((p - bb) * inv[aa, n]) % n


__END__
deal with increment 34
cut 9781
deal with increment 20
cut 8981
deal with increment 11
cut -3391
deal with increment 15
cut 1485
deal with increment 10
cut 4826
deal into new stack
cut 1026
deal with increment 30
cut 1354
deal with increment 46
cut 1955
deal with increment 19
cut 1359
deal with increment 22
cut 9483
deal with increment 52
cut -2090
deal with increment 50
deal into new stack
cut -2205
deal with increment 69
cut -7934
deal with increment 11
cut 8311
deal with increment 42
cut -5430
deal with increment 57
deal into new stack
cut -2616
deal with increment 22
deal into new stack
cut 3540
deal with increment 38
cut -9097
deal with increment 37
cut -7014
deal with increment 26
cut 6983
deal with increment 11
deal into new stack
cut -4825
deal into new stack
cut -5791
deal with increment 19
cut -3577
deal with increment 6
deal into new stack
deal with increment 29
cut 7299
deal with increment 75
cut -8498
deal with increment 21
cut 5748
deal with increment 63
cut -344
deal with increment 5
cut -4306
deal with increment 65
cut 9431
deal with increment 7
cut 6825
deal with increment 28
deal into new stack
deal with increment 66
cut -1421
deal with increment 19
cut -8965
deal with increment 48
cut -5780
deal with increment 75
cut -3280
deal with increment 50
cut 6866
deal with increment 72
cut -5471
deal with increment 49
cut -8247
deal with increment 65
cut 3056
deal into new stack
deal with increment 39
cut 7011
deal with increment 48
cut -9660
deal with increment 56
cut -6843
deal into new stack
cut 5111
deal with increment 29
cut -7700
deal into new stack
deal with increment 23
cut -5263
deal with increment 61
deal into new stack

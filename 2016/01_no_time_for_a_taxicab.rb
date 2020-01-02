require "set"
require "matrix"

DIRS = [
  Vector[ 0,  1],
  Vector[ 1,  0],
  Vector[ 0, -1],
  Vector[-1,  0],
]

dir = 0
pos = Vector[0, 0]
seen = Set.new([pos])
twice = nil

DATA.read.split(", ").each { |i|
  dir = (dir + (i[?R] ? 1 : -1)) % 4
  i[1..].to_i.times {
    pos += DIRS[dir]
    twice ||= pos if !seen.add?(pos)
  }
}

p pos.sum(&:abs), twice.sum(&:abs)

__END__
L4, L3, R1, L4, R2, R2, L1, L2, R1, R1, L3, R5, L2, R5, L4, L3, R2, R2, L5, L1, R4, L1, R3, L3, R5, R2, L5, R2, R1, R1, L5, R1, L3, L2, L5, R4, R4, L2, L1, L1, R1, R1, L185, R4, L1, L1, R5, R1, L1, L3, L2, L1, R2, R2, R2, L1, L1, R4, R5, R53, L1, R1, R78, R3, R4, L1, R5, L1, L4, R3, R3, L3, L3, R191, R4, R1, L4, L1, R3, L1, L2, R3, R2, R4, R5, R5, L3, L5, R2, R3, L1, L1, L3, R1, R4, R1, R3, R4, R4, R4, R5, R2, L5, R1, R2, R5, L3, L4, R1, L5, R1, L4, L3, R5, R5, L3, L4, L4, R2, R2, L5, R3, R1, R2, R5, L5, L3, R4, L5, R5, L3, R1, L1, R4, R4, L3, R2, R5, R1, R2, L1, R4, R1, L3, L3, L5, R2, R5, L1, L4, R3, R3, L3, R2, L5, R1, R3, L3, R2, L1, R4, R3, L4, R5, L2, L2, R5, R1, R2, L4, L4, L5, R3, L4

input = (ARGV.empty? ? DATA.read.strip : ARGV[0])

def knot_hash(input)
  list = (0..255).to_a
  position = 0

  input.each.with_index { |length, skip|
    list.rotate!(position)
    list[0, length] = list[0, length].reverse
    list.rotate!(-position)
    position += length + skip
  }

  list
end

p knot_hash(input.split(",").map(&:to_i))[0, 2].reduce(:*)

puts knot_hash((input.bytes + [17, 31, 73, 47, 23]) * 64)
  .each_slice(16)
  .map { |b| b.reduce(0, :^).to_s(16).rjust(2, "0") }
  .join

__END__
120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113

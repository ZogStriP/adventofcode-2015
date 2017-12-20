input = (ARGV.empty? ? DATA.read.strip : ARGV[0]).split.map(&:to_i)

cycle = 0
memory = {}

until memory.has_key?(input)
  memory[input.dup] = cycle
  max = input.max
  index = input.index(max)
  input[index] = 0
  max.times { |i| input[(index + i + 1) % input.size] += 1  }
  cycle += 1
end

puts memory.size
puts memory.size - memory[input]

__END__
0	5	10	0	11	14	13	4	11	8	8	7	1	4	12	11

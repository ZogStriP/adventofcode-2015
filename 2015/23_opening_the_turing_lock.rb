instructions = DATA.read.split("\n")
registers = Hash.new(0)
counter = 0

# part 2
registers["a"] = 1

while (0...instructions.size) === counter
  offset = 1
  case i = instructions[counter]
  when /hlf/ then
    registers[i[/hlf (\w)/, 1]] /= 2
  when /tpl/ then
    registers[i[/tpl (\w)/, 1]] *= 3
  when /inc/ then
    registers[i[/inc (\w)/, 1]] += 1
  when /jmp/ then
    offset = i[/jmp (.+)/, 1].to_i
  when /jie/ then
    r, o = i.scan(/jie (\w), (.+)/).flatten
    offset = o.to_i if registers[r].even?
  when /jio/ then
    r, o = i.scan(/jio (\w), (.+)/).flatten
    offset = o.to_i if registers[r] == 1
  end
  counter += offset
end

p registers["b"]

__END__
jio a, +22
inc a
tpl a
tpl a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
jmp +19
tpl a
tpl a
tpl a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
tpl a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7

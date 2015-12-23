instructions = File.readlines("day23.input").map(&:chomp!)
registers = Hash.new(0)
counter = 0

# part 2
registers["a"] = 1

while (0...instructions.size) === counter
  case i = instructions[counter]
    when /hlf/ then
      registers[i[/hlf (\w)/, 1]] /= 2
      counter += 1
    when /tpl/ then
      registers[i[/tpl (\w)/, 1]] *= 3
      counter += 1
    when /inc/ then
      registers[i[/inc (\w)/, 1]] += 1
      counter += 1
    when /jmp/ then
      counter += i[/jmp (.+)/, 1].to_i
    when /jie/ then
      register, offset = i.scan(/jie (\w), (.+)/).flatten
      offset = registers[register].even? ? offset.to_i : 1
      counter += offset
    when /jio/ then
      register, offset = i.scan(/jio (\w), (.+)/).flatten
      offset = registers[register] == 1 ? offset.to_i : 1
      counter += offset
  end
end

p registers["b"]

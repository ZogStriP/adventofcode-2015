wires = {}

instructions = File.readlines("day07.input")
while instructions.size > 0
  instructions_left = []
  instructions.each do |instruction|
    case instruction
    when /^(\d+) -> (\w+)$/ then
      input, output = instruction.scan(/^(\d+) -> (\w+)$/).flatten
      wires[output] = input.to_i & 0xFFFF
    when /^([a-z]+) -> (\w+)$/ then
      input, output = instruction.scan(/^([a-z]+) -> (\w+)$/).flatten
      if wires[input]
        wires[output] = wires[input]
      else
        instructions_left << instruction
      end
    when /^(\d+) AND ([a-z]+) -> (\w+)$/ then
      input_1, input_2, output = instruction.scan(/^(\d+) AND ([a-z]+) -> (\w+)$/).flatten
      if wires[input_2]
        wires[output] = (input_1.to_i & wires[input_2]) & 0xFFFF
      else
        instructions_left << instruction
      end
    when /^([a-z]+) AND (\d+) -> (\w+)$/ then
      input_1, input_2, output = instruction.scan(/^(\w+) AND (\w+) -> (\w+)$/).flatten
      if wires[input_1]
        wires[output] = (wires[input_1] & input_2.to_i) & 0XFFFF
      else
        instructions_left << instruction
      end
    when /^([a-z]+) AND ([a-z]+) -> (\w+)$/ then
      input_1, input_2, output = instruction.scan(/^(\w+) AND (\w+) -> (\w+)$/).flatten
      if wires[input_1] && wires[input_2]
        wires[output] = (wires[input_1] & wires[input_2]) & 0xFFFF
      else
        instructions_left << instruction
      end
    when /^(\d+) OR ([a-z]+) -> (\w+)$/ then
      input_1, input_2, output = instruction.scan(/^(\d+) OR ([a-z]+) -> (\w+)$/).flatten
      if wires[input_2]
        wires[output] = (input_1.to_i | wires[input_2]) & 0xFFFF
      else
        instructions_left << instruction
      end
    when /^([a-z]+) OR (\d+) -> (\w+)$/ then
      input_1, input_2, output = instruction.scan(/^(\w+) OR (\w+) -> (\w+)$/).flatten
      if wires[input_1]
        wires[output] = (wires[input_1] | input_2.to_i) & 0XFFFF
      else
        instructions_left << instruction
      end
    when /^([a-z]+) OR ([a-z]+) -> (\w+)$/ then
      input_1, input_2, output = instruction.scan(/^(\w+) OR (\w+) -> (\w+)$/).flatten
      if wires[input_1] && wires[input_2]
        wires[output] = (wires[input_1] | wires[input_2]) & 0xFFFF
      else
        instructions_left << instruction
      end
    when /^(\w+) LSHIFT (\d+) -> (\w+)$/ then
      input, shift, output = instruction.scan(/^(\w+) LSHIFT (\d+) -> (\w+)$/).flatten
      if wires[input]
        wires[output] = (wires[input] << shift.to_i) & 0xFFFF
      else
        instructions_left << instruction
      end
    when /^(\w+) RSHIFT (\d+) -> (\w+)$/ then
      input, shift, output = instruction.scan(/^(\w+) RSHIFT (\d+) -> (\w+)$/).flatten
      if wires[input]
        wires[output] = (wires[input] >> shift.to_i) & 0xFFFF
      else
        instructions_left << instruction
      end
    when /^NOT (\w+) -> (\w+)$/ then
      input, output = instruction.scan(/NOT (\w+) -> (\w+)$/).flatten
      if wires[input]
        wires[output] = (~wires[input]) & 0xFFFF
      else
        instructions_left << instruction
      end
    end
  end
  instructions = instructions_left.dup
end

p wires["a"]

literals  = 0
in_memory = 0
encoded   = 0

input = File.readlines("day08.input")
input.each do |line|
  literals  += line.size
  in_memory += eval(line).size
  encoded   += line.inspect.size
end

puts "PART 1: #{literals} - #{in_memory} = #{literals - in_memory}"
puts "PART 2: #{encoded} - #{literals} = #{encoded - literals}"

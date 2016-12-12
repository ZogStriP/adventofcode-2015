@instructions = File.readlines("day12.input")

def run(registers)
  i = 0

  while i < @instructions.size
    w = @instructions[i].split
    case w[0]
    when "cpy"
      registers[w[2]] = w[1][/[a-d]/] ? registers[w[1]] : w[1].to_i
    when "inc"
      registers[w[1]] += 1
    when "dec"
      registers[w[1]] -= 1
    when "jnz"
      i += w[2].to_i - 1 if (w[1][/[a-d]/] ? registers[w[1]] : w[1].to_i) != 0
    end
    i += 1
  end

  registers
end

p run("a" => 0, "b" => 0, "c" => 0, "d" => 0)["a"]
p run("a" => 0, "b" => 0, "c" => 1, "d" => 0)["a"]

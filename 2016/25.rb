def optimize(instructions)
  new_instructions = instructions.dup

  # [r] cpy b d
  # [s] inc a
  # [t] dec d
  # [u] jnz d -2
  # [v] dec c
  # [w] jnz c -5
  # => a += b * c; c = d = 0
  new_instructions.each_cons(6).with_index { |(r, s, t, u, v, w), i|
    if r[0] == "cpy" && s[0] == "inc" && t[0] == "dec" && u == ["jnz", t[1], "-2"] && v[0] == "dec" && w == ["jnz", v[1], "-5"]
      new_instructions[i + 0] = ["adm", s[1], r[1], v[1]] # a += b * c
      new_instructions[i + 1] = ["cpy", "0", v[1]] # c = 0
      new_instructions[i + 2] = ["cpy", "0", r[2]] # d = 0
      new_instructions[i + 3] = ["jnz", "0", "0"]  # nop
      new_instructions[i + 4] = ["jnz", "0", "0"]  # nop
      new_instructions[i + 5] = ["jnz", "0", "0"]  # nop
    end
  }

  new_instructions
end

def run(registers, max_items)
  i = 0
  result = []
  instructions = optimize File.readlines("25.input").map(&:split)

  while i < instructions.size && result.size < max_items
    w = instructions[i]
    case w[0]
    when "cpy" then registers[w[2]] = registers[w[1]] || w[1].to_i
    when "inc" then registers[w[1]] += 1
    when "dec" then registers[w[1]] -= 1
    when "adm" then registers[w[1]] += (registers[w[2]] || w[2].to_i) * (registers[w[3]] || w[3].to_i)
    when "jnz" then i += (registers[w[2]] || w[2].to_i) - 1 if (registers[w[1]] || w[1].to_i) != 0
    when "out" then result << (registers[w[1]] || w[1].to_i)
    end
    i += 1
  end

  result
end

SIGNAL = [0, 1] * 50

0.step { |a|
  (p a; break) if run({ "a" => a, "b" => 0, "c" => 0, "d" => 0 }, SIGNAL.size) == SIGNAL
}

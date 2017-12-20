discs = File.readlines("15.input").map { |line| line.scan(/\d+/).map(&:to_i) }
discs << [7, 11, 0, 0] # Part 2

p 0.step.find { |t| discs.all? { |d| (d[0] + d[3] + t) % d[1] == 0 } }

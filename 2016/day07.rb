BRACKETS = /\[([^\]]+)\]/
ABBA = /(.)(?!\1)(.)\2\1/

parts = File.readlines("day07.input")
            .map { |line| [line.gsub(BRACKETS, "-"), line.scan(BRACKETS).join("-")] }

# Part 1
p parts.count { |supernet, hypernet| supernet[ABBA] && !hypernet[ABBA] }

# Part 2
p parts.count { |supernet, hypernet|
  supernet.chars.each_cons(3).any? { |a, b, c| a == c && a != b && hypernet[b + a + b] }
}

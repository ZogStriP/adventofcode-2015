p File.readlines("day03.input")
      .map { |l| l.split.map(&:to_i) }
      .transpose.flatten.each_slice(3) # remove for part 1
      .count { |a, b, c| a + b > c && b + c > a && a + c > b }

p File.readlines("day03.input")
      .map { |l| l.split.map(&:to_i) }
      .transpose # remove for part 1
      .flatten
      .each_slice(3)
      .flat_map
      .count { |a, b, c| a + b > c && b + c > a && a + c > b }

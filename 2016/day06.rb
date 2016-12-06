frequencies = Array.new(8) { Hash.new(0) }

File.readlines("day06.input").each do |line|
  line.scan(/./).each_with_index { |c, i| frequencies[i][c] += 1 }
end

puts "Part 1: ", frequencies.map { |f| f.max_by { |_, v| v } }.map(&:first).join
puts "Part 2: ", frequencies.map { |f| f.min_by { |_, v| v } }.map(&:first).join

def look_and_say(string)
  string.gsub(/(\d)\1*/) { |s| "#{s.size}#{s[0]}" }
end

puzzle = "1113122113"

40.times { puzzle = look_and_say(puzzle) }
puts "40 times: #{puzzle.size}"

10.times { puzzle = look_and_say(puzzle) }
puts "50 times: #{puzzle.size}"

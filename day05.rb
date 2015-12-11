nice_strings_1 = 0
nice_strings_2 = 0

strings = File.readlines("day05.input")
strings.each do |string|
  nice_strings_1 += 1 if string.scan(/[aeiou]/).size >= 3 && string[/(.)\1/] && string !~ /(ab|cd|pq|xy)/
  nice_strings_2 += 1 if string[/(..).*\1/] && string[/(.).\1/]
end

p nice_strings_1, nice_strings_2

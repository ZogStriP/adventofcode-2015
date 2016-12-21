instructions = File.readlines("day21.input")

password = "abcdefgh"
instructions.each do |line|
  case line
  when /swap position (\d+) with position (\d+)/
    x, y = $1.to_i, $2.to_i
    password[x], password[y] = password[y], password[x]
  when /swap letter (\w) with letter (\w)/
    password.tr!("#{$2}#{$1}", "#{$1}#{$2}")
  when /rotate (left|right) (\d+) steps?/
    password = password.chars.rotate(($1["left"] ? 1 : -1) * $2.to_i).join
  when /rotate based on position of letter (\w)/
    i = password.index($1)
    rotation = -(i < 4 ? i + 1 : i + 2)
    password = password.chars.rotate(rotation).join
  when /reverse positions (\d+) through (\d+)/
    x, y = $1.to_i, $2.to_i
    password = password[0...x] + password[x..y].reverse + password[y + 1..-1]
  when /move position (\d+) to position (\d+)/
    x, y = $1.to_i, $2.to_i
    letter = password.slice!(x)
    password.insert(y, letter)
  end
end

p password

password = "fbgdceah"
instructions.reverse.each do |line|
  case line
  when /swap position (\d+) with position (\d+)/
    x, y = $1.to_i, $2.to_i
    password[x], password[y] = password[y], password[x]
  when /swap letter (\w) with letter (\w)/
    password.tr!("#{$2}#{$1}", "#{$1}#{$2}")
  when /rotate (left|right) (\d+) steps?/
    password = password.chars.rotate(($1["left"] ? -1 : 1) * $2.to_i).join # diff
  when /rotate based on position of letter (\w)/
    i = password.index($1)
    rotation = i / 2 + (i % 2 == 1 || i == 0 ? 1 : 5) # diff
    password = password.chars.rotate(rotation).join
  when /reverse positions (\d+) through (\d+)/
    x, y = $1.to_i, $2.to_i
    password = password[0...x] + password[x..y].reverse + password[y + 1..-1]
  when /move position (\d+) to position (\d+)/
    x, y = $2.to_i, $1.to_i # diff
    letter = password.slice!(x)
    password.insert(y, letter)
  end
end

p password

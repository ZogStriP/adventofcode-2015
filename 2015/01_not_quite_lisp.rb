floor = 0
position = 1

directions = File.read("01.input").strip
directions.split("").each do |d|
  d == "(" ? floor += 1 : floor -= 1
  break if floor == -1
  position += 1
end

p position

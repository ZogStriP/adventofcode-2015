directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

face = 0
position = [0, 0]
visited = { position => true }
found = false

File.read("day01.input").split(", ").each do |instruction|
  face = (face + (instruction[0]["R"] ? 1 : -1)) % 4
  instruction[1..-1].to_i.times do
    position = [position, directions[face]].transpose.map { |a| a.reduce(:+) }
    if visited[position] && !found
      puts "Part 2: #{position.map(&:abs).reduce(:+)}"
      found = true
    end
    visited[position] = true
  end
end

puts "Part 1: #{position.map(&:abs).reduce(:+)}"

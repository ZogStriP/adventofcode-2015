# keypad = [
#   ["1", "2", "3"],
#   ["4", "5", "6"],
#   ["7", "8", "9"],
# ]

# position = [1, 1]

keypad = [
  ["X", "X", "1", "X", "X"],
  ["X", "2", "3", "4", "X"],
  ["5", "6", "7", "8", "9"],
  ["X", "A", "B", "C", "X"],
  ["X", "X", "D", "X", "X"],
]

position = [1, 2]

max = keypad[0].size - 1

directions = {
  "U" => [-1, 0],
  "D" => [1, 0],
  "L" => [0, -1],
  "R" => [0, 1],
}

instructions = File.read("day02.input").strip
instructions.split("\n").each do |line|
  line.chars do |d|
    new_position = [
      [0, [position[0] + directions[d][0], max].min].max,
      [0, [position[1] + directions[d][1], max].min].max,
    ]
    position = new_position unless keypad[new_position[0]][new_position[1]] == "X"
  end
  putc keypad[position[0]][position[1]]
end

puts

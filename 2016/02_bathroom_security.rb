# Part 1
# position = [1, 1]
# keypad = [
#   ["1", "2", "3"],
#   ["4", "5", "6"],
#   ["7", "8", "9"],
# ]

# Part 2
position = [2, 0]
keypad = [
  [nil, nil, "1", nil, nil],
  [nil, "2", "3", "4", nil],
  ["5", "6", "7", "8", "9"],
  [nil, "A", "B", "C", nil],
  [nil, nil, "D", nil, nil],
]

max = keypad[0].size - 1

directions = {
  "U" => [-1, 0],
  "D" => [1, 0],
  "L" => [0, -1],
  "R" => [0, 1],
}

File.read("02.input").split.each do |line|
  line.chars do |d|
    new_position = [
      [0, [max, position[0] + directions[d][0]].min].max,
      [0, [max, position[1] + directions[d][1]].min].max,
    ]
    position = new_position if keypad[new_position[0]][new_position[1]]
  end
  putc keypad[position[0]][position[1]]
end

puts

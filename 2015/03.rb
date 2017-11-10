require "set"

Point = Struct.new(:x, :y)

santa_position = Point.new(0, 0)
robot_position = Point.new(0, 0)

visited_houses = Set.new([santa_position.dup])

def move!(direction, position)
  case direction
  when ">" then position.x += 1
  when "<" then position.x -= 1
  when "^" then position.y += 1
  when "v" then position.y -= 1
  end
end

input = File.read("03.input").strip
input.split("").each_with_index do |direction, index|
  if index.even?
    move!(direction, santa_position)
    visited_houses << santa_position.dup
  else
    move!(direction, robot_position)
    visited_houses << robot_position.dup
  end
end

p visited_houses.size

STEPS = 100

NEIGHBORS = [
  [-1, -1],
  [-1,  0],
  [-1,  1],
  [ 0, -1],
  [ 0,  1],
  [ 1, -1],
  [ 1,  0],
  [ 1,  1],
]

CORNERS = [
  [ 0,  0],
  [ 0, 99],
  [99,  0],
  [99, 99],
]

@lights = Array.new(100) { Array.new(100) }

def neighbors_on(x, y)
  NEIGHBORS.map do |n|
    nx = x + n[0]
    ny = y + n[1]
    @lights[nx][ny] if (0...100) === nx && (0...100) === ny
  end.count { |l| l }
end

File.readlines("day18.input").each_with_index do |line, x|
  line.chomp.split("").each_with_index do |l, y|
    @lights[x][y] = l == "#" || CORNERS.include?([x, y])
  end
end

STEPS.times do
  new_lights = Array.new(100) { Array.new(100) }

  100.times do |x|
    100.times do |y|
      n = neighbors_on(x, y)
      new_lights[x][y] = n == 3 || (n == 2 && @lights[x][y]) || CORNERS.include?([x, y])
    end
  end

  @lights = new_lights
end

p @lights.flatten.count { |l| l }

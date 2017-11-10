Node = Struct.new(:x, :y, :size, :used, :avail, :use_p)

nodes = File.readlines("22.input").drop(2).map { |line|
  Node.new *line.scan(/\d+/).map(&:to_i)
}

# Part 1
p nodes.permutation(2).count { |a, b| a.used > 0 && a.used <= b.avail }

# Part 2
width  = nodes.map(&:x).max + 1
height = nodes.map(&:y).max + 1

grid = Array.new(height) { Array.new(width) }
nodes.each { |n| grid[n.y][n.x] = n }

height.times { |y|
  width.times { |x|
    if x == 0 && y == 0           then putc "X"
    elsif x == width -1 && y == 0 then putc "G"
    elsif grid[y][x].size > 100   then putc "#"
    elsif grid[y][x].used == 0    then putc "_"
    else putc "·"
    end
  }
  putc "\n"
}

p 14 + # left around the wall
  25 + # up to the top
  27 + # right next to G
  (35 * 5) + # move G to the left
  1

START  = [1, 1]
FINISH = [31, 39]
MOVES  = [[1, 0], [0, 1], [-1, 0], [0, -1]]

def is_open_space?(x, y)
  x >= 0 && y >= 0 && ((x * x) + (3 * x) + (2 * x * y) + y + (y * y) + 1364).to_s(2).count("1").even?
end

queue = [START]
visited = { START => 0 }

while position = queue.shift
  p visited[position] if position == FINISH

  MOVES.each do |m|
    n = [position[0] + m[0], position[1] + m[1]]
    next unless is_open_space?(*n) && !visited[n]
    visited[n] = visited[position] + 1
    queue << n
  end
end

p visited.values.count { |s| s <= 50 }

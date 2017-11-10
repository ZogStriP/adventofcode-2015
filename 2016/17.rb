require "digest"

START  = [0, 0]
FINISH = [3, 3]
MOVES  = [[-1, 0, "U"], [1, 0, "D"], [0, -1, "L"], [0, 1, "R"]]

queue = [[START, "bwnlcvfs"]]
longest = nil

while position = queue.shift
  if position[0] == FINISH
    p position unless longest
    longest = position[1]
    next
  end

  h = Digest::MD5.hexdigest(position[1])

  MOVES.each.with_index do |m, i|
    next unless "bcdef".include?(h[i])
    n = [position[0][0] + m[0], position[0][1] + m[1]]
    next unless n[0] >= 0 && n[1] >= 0 && n[0] <= 3 && n[1] <= 3
    queue << [n, position[1] + m[2]]
  end
end

p longest.size - "bwnlcvfs".size

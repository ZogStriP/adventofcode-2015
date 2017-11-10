start = nil
checkpoints = []

CLOSED = File.readlines("24.input").map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    start ||= [y, x]      if c == "0"
    checkpoints << [y, x] if c =~ /\d/
    c == "#"
  }
}

def bfs(from)
  d = { from => 0 }
  q = [from]

  while pos = q.shift
    y, x = pos
    [
      [y - 1, x],
      [y + 1, x],
      [y, x - 1],
      [y, x + 1]
    ].each { |n|
       next if CLOSED[n[0]][n[1]] || d[n]
       d[n] = d[pos] + 1
       q << n
     }
  end

  d
end

distances = Hash.new { |h, k| h[k] = {} }
points = [start] + checkpoints

points.each { |from|
  d = bfs(from)
  points.each { |to|
    distances[from][to] = d[to]
    distances[to][from] = d[to]
  }
}

p checkpoints.permutation.map { |path| [
  ([start] + path).each_cons(2).map { |a, b| distances[a][b] }.reduce(:+),
  ([start] + path + [start]).each_cons(2).map { |a, b| distances[a][b] }.reduce(:+)
]}.min

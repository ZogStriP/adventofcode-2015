Marble = Struct.new(:value, :left, :right)

def play(players, marbles)
  scores = [0] * players
  current = Marble.new(0)
  current.left = current
  current.right = current

  (1..marbles).each { |m|
    if m % 23 == 0
      7.times { current = current.left }
      scores[m % players] += m + current.value
      current.left.right = current.right
      current = current.right
    else
      l = current.right
      r = l.right
      marble = Marble.new(m, l, r)
      l.right = marble
      r.left = marble
      current = marble
    end
  }

  scores.max
end

p play(430, 71_588)
p play(430, 71_588 * 100)

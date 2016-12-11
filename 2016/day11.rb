# (2 * n - 3) steps to move n items from one level to another [where n >= 3]

p (1...4).reduce(0) { |sum, x| sum + 2 * [8, 2, 0, 0].take(x).reduce(:+) - 3 }
p (1...4).reduce(0) { |sum, x| sum + 2 * [12, 2, 0, 0].take(x).reduce(:+) - 3 }

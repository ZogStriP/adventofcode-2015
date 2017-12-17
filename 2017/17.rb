steps = 355
buffer = [0]
position = 0

(1..2017).each { |i|
  position = (position + steps) % buffer.size + 1
  buffer.insert(position, i)
}

p buffer[position + 1]

n = 0
position = 0

(1..50_000_000).each { |i|
  position = (position + steps) % i + 1
  n = i if position == 1
}

p n

require "prime"

TARGET = 29000000
MAX    = TARGET / 10

# part 1
houses = Array.new(MAX + 1, 10)

2.upto(MAX) do |i|
  i.step(MAX, i) do |j|
    houses[j] += i * 10
  end
end

p houses.index { |h| h >= TARGET }

# part 2
houses = Array.new(MAX + 1, 11)

2.upto(MAX) do |i|
  i.step(MAX, i).first(50).each do |j|
    houses[j] += i * 11
  end
end

p houses.index { |h| h >= TARGET }

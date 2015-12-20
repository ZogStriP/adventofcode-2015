require "prime"

TARGET = 29000000
MAX    = TARGET / 10

# part 1
house = Array.new(MAX, 10)

(2...MAX).each do |i|
  (i...MAX).step(i).each do |j|
    house[j] += i * 10
  end
end

p house.index { |h| h >= TARGET }

# part 2
house = Array.new(TARGET, 10)

(2...MAX).each do |i|
  (i...MAX).step(i).first(50).each do |j|
    house[j] += i * 11
  end
end

p house.index { |h| h >= TARGET }

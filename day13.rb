require "set"

guests = Set.new
happiness = Hash.new(0)

lines = File.readlines("day13.input")
lines.each do |line|
  left, sign, value, right = line.scan(/(\w+) would (lose|gain) (\d+) happiness units by sitting next to (\w+)./).flatten
  value = value.to_i * (sign == "lose" ? -1 : 1)
  guests << left << right
  happiness["#{left}-#{right}"] = value
end

guests << "Régis"

max = 0
guests.to_a.permutation.each do |seating|
  seating << seating[0]
  happy = seating.each_cons(2).map { |s| happiness["#{s[0]}-#{s[1]}"] + happiness["#{s[1]}-#{s[0]}"] }.inject(:+)
  max = happy if happy > max
end

p max

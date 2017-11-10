@the_sue = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1,
}

def part_1?(a_sue)
  @the_sue.merge(a_sue) == @the_sue
end

def part_2?(a_sue)
  a_sue.keys.all? do |c|
    if c.to_s[/cats|trees/]
      a_sue[c] > @the_sue[c]
    elsif c.to_s[/pomeranians|goldfish/]
      a_sue[c] < @the_sue[c]
    else
      a_sue[c] == @the_sue[c]
    end
  end
end

File.readlines("16.input").each do |line|
  sue = line[/Sue (\d+)/, 1]
  a_sue = line.scan(/(\w+): (\d+)/).map { |c, q| [c.to_sym,  q.to_i] }.to_h
  puts "PART 1: #{sue}" if part_1?(a_sue)
  puts "PART 2: #{sue}" if part_2?(a_sue)
end

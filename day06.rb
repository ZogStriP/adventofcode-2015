@lights = Array.new(1_000_000, 0)

def turn_on(x1, y1, x2, y2)
  (x1..x2).each do |x|
    (y1..y2).each do |y|
      @lights[x + y * 1000] += 1
    end
  end
end

def turn_off(x1, y1, x2, y2)
  (x1..x2).each do |x|
    (y1..y2).each do |y|
      next if @lights[x + y * 1000] == 0
      @lights[x + y * 1000] -= 1
    end
  end
end

def toggle(x1, y1, x2, y2)
  (x1..x2).each do |x|
    (y1..y2).each do |y|
      @lights[x + y * 1000] += 2
    end
  end
end

instructions = File.readlines("day06.input")
instructions.each do |string|
  x1, x2, y1, y2 = string.scan(/\d+/).map(&:to_i)
  if string.start_with?("turn on")
    turn_on(x1, x2, y1, y2)
  elsif string.start_with?("turn off")
    turn_off(x1, x2, y1, y2)
  elsif string.start_with?("toggle")
    toggle(x1, x2, y1, y2)
  end
end

p @lights.reduce(:+)

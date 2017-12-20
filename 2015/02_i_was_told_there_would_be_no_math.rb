presents = File.readlines("02.input")

paper  = 0
ribbon = 0

presents.each do |present|
  w, h, l = present.split("x").map(&:to_i).sort
  paper  += (3 * w * h) + (2 * w * l) + (2 * h * l)
  ribbon += (2 * w) + (2 * h) + (w * h * l)
end

p paper, ribbon

require "digest"

h = nil
index = 0
door_id = "reyedfim"

part_2 = [nil] * 8

while part_2.any?(&:nil?) do
  until (h = Digest::MD5.hexdigest("#{door_id}#{index += 1}"))[/^0{5}/] do; end
  putc h[5] # hacking in progress...
  part_2[h[5].to_i] ||= h[6] if ("0".."7") === h[5]
end

puts "", part_2.join

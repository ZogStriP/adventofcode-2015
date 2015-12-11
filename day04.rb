require "digest"

i = 0

loop do
  break if Digest::MD5.hexdigest("bgvyzdsv#{i}").start_with?("000000")
  i += 1
end

p i

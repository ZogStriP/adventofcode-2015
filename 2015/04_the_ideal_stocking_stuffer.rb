require "digest/md5"

SECRET_KEY = "bgvyzdsv"

p (1..).find { |n| Digest::MD5.hexdigest(SECRET_KEY + n.to_s).start_with? "00000" }
p (1..).find { |n| Digest::MD5.hexdigest(SECRET_KEY + n.to_s).start_with? "000000" }


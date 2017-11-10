require "digest"

SALT = "ngcjuoqr"

@hashes = {}

def hash(index)
  h = "#{SALT}#{index}"
  @hashes[h] ||= (1..2017).inject(h) { |h| Digest::MD5.hexdigest(h) }
end

index = 0
keys = []

while keys.size < 64 do
  if c = hash(index)[/(\h)\1\1/, 1]
    (1..1000).each { |i|
      (keys << index; break) if hash(index + i)[c * 5]
    }
  end
  index += 1
end

p keys

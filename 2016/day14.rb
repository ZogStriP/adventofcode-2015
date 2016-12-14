require "digest"

SALT = "ngcjuoqr"

@hashes = {}

def hash(index)
  key = "#{SALT}#{index}"
  @hashes[key] ||= begin
    h = Digest::MD5.hexdigest(key)
    2016.times { h = Digest::MD5.hexdigest(h) }
    h
  end
end

index = 0
keys = []

while keys.size < 64 do
  if c = hash(index)[/(\h)\1{2}/, 1]
    [*1..1000].each do |i|
      if hash(index + i)[c * 5]
        keys << index
        break
      end
    end
  end
  index += 1
end

p keys

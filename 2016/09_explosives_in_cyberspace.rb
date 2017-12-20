def decompress(file, deep = false)
  return file.size unless marker = file =~ /\((\d+)x(\d+)\)/
  size, chars, times = $&.size, $1.to_i, $2.to_i
  offset = marker + size
  f = file[offset...offset + chars]
  marker + (deep ? decompress(f, deep) : f.size) * times + decompress(file[offset + chars..-1], deep)
end

compressed = File.read("09.input").strip

p decompress(compressed)
p decompress(compressed, true)

[272, 35651584].each { |size|
  d = "10001001100000001"
  d += "0" + d.reverse.tr("01", "10") while d.size < size
  d = d[0...size].chars
  d = d.each_slice(2).map { |a, b| a == b ? "1" : "0" } while d.size.even?
  p d.join
}

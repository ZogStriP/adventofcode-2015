min   = DATA.readline.to_i
buses = DATA.readline.split(?,).map.with_index { |b, i| b[?x] ? nil : [b.to_i, i] }.compact

p buses.map { |b, _| [-min % b, b] }.min_by(&:first).reduce(:*)

step = 1
timestamp = 0

buses.each { |b, i|
  timestamp += step until (timestamp + i) % b == 0
  step *= b
}

p timestamp

__END__
1004345
41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,379,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,557,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19

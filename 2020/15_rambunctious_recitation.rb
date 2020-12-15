T = []

init = DATA.read.split(?,).map(&:to_i)
init.each_with_index { |n, i| T[n] = i + 1 }

last = 0

(init.size + 1...30000000).each { |t|
  tt = T[last]
  T[last] = t
  last = tt ? t - tt : 0
  p last if t == 2019
}

p last

__END__
5,2,8,16,18,0,1

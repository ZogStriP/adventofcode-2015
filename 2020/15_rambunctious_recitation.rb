T = []

init = DATA.read.split(?,).map(&:to_i)
init.each.with_index(1) { |n, i| T[n] = i }

last = 0

(init.size + 1...30000000).each { |t|
  p last if t == 2020
  tt = T[last]
  T[last] = t
  last = t - (tt || t)
}

p last

__END__
5,2,8,16,18,0,1

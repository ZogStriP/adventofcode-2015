moons = DATA.each_line.map { |l| [l.scan(/-?\d+/).map(&:to_i), [0, 0, 0]] }
start = moons.map(&:first).transpose

1000.times {
  moons = moons.map { |p, v|
    vv = v.zip(*moons.map { |pp, _| pp.zip(p).map { |a, b| a <=> b }}).map(&:sum)
    [p.zip(vv).map(&:sum), vv]
  }
}

p moons.sum { |p, v| p.sum(&:abs) * v.sum(&:abs) }

def period(a)
  v = [0] * a.size

  (1..).each { |t|
    g = a.map { |b| a.sum { |c| c <=> b }}
    v = v.zip(g).map(&:sum)
    a = a.zip(v).map(&:sum)
    return t * 2 if v.all?(&:zero?)
  }
end

p start.map { |a| period(a) }.reduce(1) { |a, b| a.lcm(b) }

__END__
<x=-4, y=3, z=15>
<x=-11, y=-10, z=13>
<x=2, y=2, z=18>
<x=7, y=-1, z=0>

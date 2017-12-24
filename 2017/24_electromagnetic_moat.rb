components = DATA.readlines.map { |l| l.split("/").map(&:to_i) }

def bridges(port, bridge, strength, left, &block)
  left.select { |c| c.include?(port) }.each { |c|
    b = bridge + [c]
    s = strength + c.sum
    yield [b, s]
    bridges(c[0] == port ? c[1] : c[0], b, s, left.select { |x| x != c }, &block)
  }
end

possible_bridges = []

bridges(0, [], 0, components) { |b| possible_bridges << b }

p possible_bridges.max_by { |b| b[1] }[1]
p possible_bridges.max_by { |b| [b[0].size, b[1]] }[1]

__END__
31/13
34/4
49/49
23/37
47/45
32/4
12/35
37/30
41/48
0/47
32/30
12/5
37/31
7/41
10/28
35/4
28/35
20/29
32/20
31/43
48/14
10/11
27/6
9/24
8/28
45/48
8/1
16/19
45/45
0/4
29/33
2/5
33/9
11/7
32/10
44/1
40/32
2/45
16/16
1/18
38/36
34/24
39/44
32/37
26/46
25/33
9/10
0/29
38/8
33/33
49/19
18/20
49/39
18/39
26/13
19/32

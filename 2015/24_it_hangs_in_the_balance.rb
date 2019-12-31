weights = DATA.read.split("\n").map(&:to_i).sort

@groups = 3 # 4 for part 2
@sum = weights.sum / @groups

def quantum(weights, groups)
  (1..weights.size).each do |s|
    weights.combination(s).each do |c|
      if c.sum == @sum
        return true if groups == 2
        return quantum(weights - c, groups - 1) if groups < @groups
        return c.reduce(:*) if quantum(weights - c, groups - 1)
      end
    end
  end
end

p quantum(weights, @groups)

__END__
1
2
3
7
11
13
17
19
23
31
37
41
43
47
53
59
61
67
71
73
79
83
89
97
101
103
107
109
113

points = DATA.each_line.map { |l| l.scan(/\d+/).map(&:to_i) }

xmin, xmax = points.map(&:first).minmax
ymin, ymax = points.map(&:last).minmax

areas = Hash.new(0)
edges = {}
safe  = 0

(xmin..xmax).each { |x|
  (ymin..ymax).each { |y|
    best_p = nil
    best_d = Float::INFINITY
    total  = 0

    points.each { |p|
      d = (p[0] - x).abs + (p[1] - y).abs
      total += d

      if d < best_d
        best_p = p
        best_d = d
      elsif d == best_d
        best_p = nil
      end
    }

    safe += 1 if total < 10_000

    next unless best_p

    edges[best_p] ||= x == xmin || x == xmax || y == ymin || y == ymax
    areas[best_p] += 1
  }
}

p points.select { |p| !edges[p] }.map { |p| areas[p] }.max
p safe

__END__
267, 196
76, 184
231, 301
241, 76
84, 210
186, 243
251, 316
265, 129
142, 124
107, 134
265, 191
216, 226
67, 188
256, 211
317, 166
110, 41
347, 332
129, 91
217, 327
104, 57
332, 171
257, 287
230, 105
131, 209
110, 282
263, 146
113, 217
193, 149
280, 71
357, 160
356, 43
321, 123
272, 70
171, 49
288, 196
156, 139
268, 163
188, 141
156, 182
199, 242
330, 47
89, 292
351, 329
292, 353
290, 158
167, 116
268, 235
124, 139
116, 119
142, 259

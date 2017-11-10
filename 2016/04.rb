rooms = File.readlines("04.input")
            .map { |l| [l[/[^\d]+/].tr("-", ""), l[/\d+/].to_i, l[/\[([a-z]+)\]$/, 1]] }

# Part 1
p rooms.select { |r| r[2] == r[0].chars.group_by { |c| c }.sort_by { |k, v| [-v.size, k] }.map(&:first).join[0..4] }
       .map { |r| r[1] }
       .reduce(:+)

# Part 2
alphabet = ('a'..'z').to_a.join
p rooms.select { |r| r[0].tr(alphabet, ('a'..'z').to_a.rotate(r[1]).join)["northpole"] }

ROWS = 6
COLUMNS = 50

display = Array.new(ROWS) { Array.new(COLUMNS) }

File.readlines("day08.input").each do |line|
  w = line.split
  case w[0]
  when "rect"
    col, row = w[1].split("x").map(&:to_i)
    row.times { |r| col.times { |c| display[r][c] = true } }
  when "rotate"
    c =  w[2][/\d+/].to_i
    a = -w[4][/\d+/].to_i
    case w[1]
    when "row"
      display[c].rotate!(a)
    when "column"
      cc = ROWS.times.map { |r| display[r][c] }.rotate(a)
      ROWS.times { |r| display[r][c] = cc[r] }
    end
  end
end

# Part 1
p display.map { |r| r.count(true) }.reduce(:+)

# Part 2
display.each do |r|
  puts r.map { |c| c ? "\u2588" : " " }.join
end

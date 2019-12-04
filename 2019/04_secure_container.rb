passwords = (153517..630395)
  .map(&:digits)
  .select { |d| d.each_cons(2).all? { |a, b| a >= b } }
  .map { |d| d.group_by(&:itself).values.map(&:size) }

p passwords.count { |p| p.any? { |s| s >= 2 } }
p passwords.count { |p| p.include?(2) }

input = DATA.read.split("\n")

@open  = []
@width = input[0].size

Unit = Struct.new(:position, :elf, :hp, :att)

starting_units = []

input.each_with_index { |r, y|
  r.each_char.with_index { |c, x|
    p = x + y * @width
    case c
    when "E"
      starting_units << Unit.new(p, true, 200, 3)
      @open[p] = true
    when "G"
      starting_units << Unit.new(p, false, 200, 3)
      @open[p] = true
    when "."
      @open[p] = true
    when "#"
      @open[p] = false
    end
  }
}

def adjacents(p)
  [
    p - @width, # up
    p - 1,      # left
    p + 1,      # right
    p + @width, # down
  ]
end

def round(units)
  units.sort_by(&:position).each do |unit|
    next if unit.hp <= 0

    targets = units.select { |u| u.elf != unit.elf }.map { |u| [u.position, u] }.to_h
    return false if targets.empty?

    # move
    unless target = adjacents(unit.position).map(&targets).compact.sort_by(&:position).first
      occupied = units.map { |u| [u.position, true] }.to_h

      goals = targets.flat_map { |p, _| adjacents(p) }.map { |p| [p, true] }.to_h
      prev  = { unit.position => nil }
      queue = [unit.position]
      found = []

      until queue.empty?
        q = []
        while c = queue.shift
          found << c if goals[c]
          next if !found.empty?
          adjacents(c)
            .select { |a| @open[a] && !occupied[a] && !prev.has_key?(a) }
            .each { |a| q << a; prev[a] = c }
        end
        queue = q if found.empty?
      end

      if !found.empty?
        p = found.min
        p = prev[p] while prev[p] != unit.position
        unit.position = p
      end
    end

    # attack
    if target = adjacents(unit.position).map(&targets).compact.sort_by { |u| [u.hp, u.position] }.first
      target.hp -= unit.att
      units.delete(target) if target.hp <= 0
    end
  end

  true
end

units = Marshal.load(Marshal.dump(starting_units))
rounds = 0.step.find { !round(units) }
p units.sum(&:hp) * rounds

4.step { |att|
  units = Marshal.load(Marshal.dump(starting_units))
  units.select(&:elf).each { |u| u.att = att }
  rounds = 0.step.find { !round(units) }
  if units.count(&:elf) == starting_units.count(&:elf)
    break p units.sum(&:hp) * rounds
  end
}

__END__
################################
####################..#..#######
####################.......#####
####################..##...###.#
####################...........#
###########G.....###..##.......#
############..##.G###....G.....#
############G..#..###.........##
##########..G..#.####.#G.......#
##########.#.....####..........#
##########.G.......#....E...####
##########GG................####
########..G..G#####..........###
######.......#######.....#.#####
#####GG..G..#########....#..####
#####.......#########.......####
####....G...#########...###.####
####...G....#########..E###.####
##....G.....#########.G.##..#..#
#.....#......#######E..##......#
##...###......#####...###......#
####..................#.....E###
####.######..G......#.......####
#######.........E.....###...####
#######..............E####.#####
##########..G........###########
##########............##########
###########..E....#.E.##########
#########...............########
#########..E......##.....#######
#########.#####.E.###.....######
################################

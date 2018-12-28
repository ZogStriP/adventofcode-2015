Group = Struct.new(:immune, :units, :hp, :damage, :attack_type, :initiative, :target, :targeted, :weak_to, :immune_to) do
  def effective_power
    damage * units
  end

  def damage_taken(group)
    if immune_to&.include?(group.attack_type)
      0
    elsif weak_to&.include?(group.attack_type)
      group.effective_power * 2
    else
      group.effective_power
    end
  end

  def defeated?
    units <= 0
  end
end

immune = true
base_groups = []

DATA.each_line { |line|
  if line["Infection"]
    immune = false
  elsif line[/\d+/]
    units, hp, misc, damage, attack_type, initiative = line.scan(/(\d+) units each with (\d+) hit points (.*)with an attack that does (\d+) (\w+) damage at initiative (\d+)/)[0]

    group = Group.new(immune, units.to_i, hp.to_i, damage.to_i, attack_type, initiative.to_i)

    if misc.size > 0
      misc = misc[1..-3].split("; ")
      if w = misc.find { |m| m["weak to "] }
        group.weak_to = w["weak to ".size..-1].split(", ")
      end
      if i = misc.find { |m| m["immune to "] }
        group.immune_to = i["immune to ".size..-1].split(", ")
      end
    end

    base_groups << group
  end
}

0.step { |boost|
  groups = base_groups.map(&:dup)
  groups.select(&:immune).each { |g| g.damage += boost }

  while groups.map(&:immune).uniq.size > 1
    groups.reject!(&:defeated?)
    groups.each { |g| g.target = g.targeted = nil }

    total_units_lost = 0

    # target selection
    groups.sort_by { |g| [-g.effective_power, -g.initiative] }.each { |group|
      target = groups.select { |g| g.immune != group.immune && !g.targeted && g.damage_taken(group) > 0 }
                     .max_by { |g| [g.damage_taken(group), g.effective_power, g.initiative] }
      if target
        group.target = target
        target.targeted = true
      end
    }

    # attacking
    groups.sort_by { |g| -g.initiative }.each { |group|
      next if group.defeated? || !group.target
      units_lost = group.target.damage_taken(group) / group.target.hp
      total_units_lost += units_lost
      group.target.units -= units_lost
    }

    break if groups.count(&:defeated?) == 0 && total_units_lost == 0
  end

  p groups.sum(&:units) if boost == 0
  break p groups.sum(&:units) if groups.all?(&:immune)
}

__END__
Immune System:
273 units each with 8289 hit points (immune to bludgeoning; weak to radiation, slashing) with an attack that does 261 cold damage at initiative 2
2016 units each with 10188 hit points (weak to slashing, radiation; immune to cold, bludgeoning) with an attack that does 47 bludgeoning damage at initiative 14
3638 units each with 9600 hit points (weak to fire, cold) with an attack that does 26 radiation damage at initiative 18
4154 units each with 3839 hit points with an attack that does 9 slashing damage at initiative 7
2872 units each with 4441 hit points (immune to radiation; weak to slashing) with an attack that does 14 cold damage at initiative 15
906 units each with 10657 hit points (immune to fire) with an attack that does 105 fire damage at initiative 16
4497 units each with 8474 hit points (immune to slashing, radiation; weak to cold) with an attack that does 18 slashing damage at initiative 1
2246 units each with 6792 hit points (weak to bludgeoning) with an attack that does 27 cold damage at initiative 17
3246 units each with 1380 hit points (weak to radiation; immune to cold) with an attack that does 4 cold damage at initiative 5
5042 units each with 10450 hit points with an attack that does 18 fire damage at initiative 11

Infection:
982 units each with 23562 hit points with an attack that does 47 radiation damage at initiative 6
601 units each with 44172 hit points (immune to radiation) with an attack that does 120 fire damage at initiative 12
6035 units each with 9260 hit points (immune to slashing; weak to fire) with an attack that does 2 fire damage at initiative 4
476 units each with 34584 hit points (weak to slashing, fire) with an attack that does 130 slashing damage at initiative 3
6608 units each with 46197 hit points with an attack that does 13 fire damage at initiative 8
275 units each with 37639 hit points (immune to cold, fire) with an attack that does 250 radiation damage at initiative 9
1428 units each with 47260 hit points (weak to slashing) with an attack that does 64 bludgeoning damage at initiative 19
8479 units each with 23902 hit points (weak to slashing, fire) with an attack that does 4 bludgeoning damage at initiative 13
2620 units each with 11576 hit points (weak to radiation, bludgeoning) with an attack that does 7 radiation damage at initiative 10
2107 units each with 30838 hit points (weak to radiation, fire) with an attack that does 28 cold damage at initiative 20

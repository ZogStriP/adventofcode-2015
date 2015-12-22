MISSILE  = 0
DRAIN    = 1
SHIELD   = 2
POISON   = 3
RECHARGE = 4

SPELL_COSTS  = [53, 73, 113, 173, 229]
SPELL_TIMERS = [1, 1, 6, 6, 5]

def deep_dup(object)
  Marshal.load(Marshal.dump(object))
end

nodes = [
  {
    hero_hp: 50,
    hero_mana: 500,
    hero_armor: 0,
    boss_hp: 58,
    boss_damage: 9,
    mana_spent: 0,
    spell_timers: [0, 0, 0, 0, 0],
    is_hero_turn: true,
  }
]

until nodes.empty? do
  n = nodes.shift

  # reset armor
  n[:hero_armor] = 0

  # PART 2: hard mode
  if n[:is_hero_turn]
    n[:hero_hp] -= 1
    next if n[:hero_hp] <= 0
  end

  # apply spell effects
  0.upto(4) do |s|
    if n[:spell_timers][s] > 0
      n[:spell_timers][s] -= 1
      case s
      when MISSILE  then n[:boss_hp] -= 4
      when DRAIN    then n[:boss_hp] -= 2; n[:hero_hp] += 2
      when SHIELD   then n[:hero_armor] = 7
      when POISON   then n[:boss_hp] -= 3
      when RECHARGE then n[:hero_mana] += 101
      end
    end
  end

  next  if n[:hero_hp] <= 0
  break if n[:boss_hp] <= 0 # \o/

  if n[:is_hero_turn]
    0.upto(4) do |s|
      if n[:spell_timers][s] == 0 && n[:hero_mana] >= SPELL_COSTS[s]
        node = deep_dup(n)
        node[:hero_mana] -= SPELL_COSTS[s]
        node[:mana_spent] += SPELL_COSTS[s]
        node[:spell_timers][s] = SPELL_TIMERS[s]
        node[:is_hero_turn] = !node[:is_hero_turn]
        nodes << node
      end
    end
  else
    node = deep_dup(n)
    node[:hero_hp] -= [1, n[:boss_damage] - n[:hero_armor]].max
    node[:is_hero_turn] = !node[:is_hero_turn]
    nodes << node
  end
end

p n[:mana_spent]

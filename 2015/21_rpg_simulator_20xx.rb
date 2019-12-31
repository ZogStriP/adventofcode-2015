HERO_HIT_POINTS = 100.0
BOSS_HIT_POINTS = 103.0
BOSS_DAMAGE     =   9
BOSS_ARMOR      =   2

WEAPONS = [
  { cost:  8, damage: 4, armor: 0 },
  { cost: 10, damage: 5, armor: 0 },
  { cost: 25, damage: 6, armor: 0 },
  { cost: 40, damage: 7, armor: 0 },
  { cost: 74, damage: 8, armor: 0 },
]

ARMORS = [
  { cost:   0, damage: 0, armor: 0 },
  { cost:  13, damage: 0, armor: 1 },
  { cost:  31, damage: 0, armor: 2 },
  { cost:  53, damage: 0, armor: 3 },
  { cost:  75, damage: 0, armor: 4 },
  { cost: 102, damage: 0, armor: 5 },
]

RINGS = [
  { cost:   0, damage: 0, armor: 0 },
  { cost:  25, damage: 1, armor: 0 },
  { cost:  50, damage: 2, armor: 0 },
  { cost: 100, damage: 3, armor: 0 },
  { cost:  20, damage: 0, armor: 1 },
  { cost:  40, damage: 0, armor: 2 },
  { cost:  80, damage: 0, armor: 3 },
]

min = 1.0 / 0
max = 0

WEAPONS.each { |weapon|
  ARMORS.each { |armor|
    RINGS.combination(2).each { |ring_1, ring_2|
      hero_damage = weapon[:damage] + ring_1[:damage] + ring_2[:damage]
      hero_armor = armor[:armor] + ring_1[:armor] + ring_2[:armor]
      hero_damages_dealt = [1, hero_damage - BOSS_ARMOR].max
      boss_damages_dealt = [1, BOSS_DAMAGE - hero_armor].max
      gold = weapon[:cost] + armor[:cost] + ring_1[:cost] + ring_2[:cost]
      if (BOSS_HIT_POINTS / hero_damages_dealt).ceil <= (HERO_HIT_POINTS / boss_damages_dealt).ceil
        min = gold if gold < min
      else
        max = gold if gold > max
      end
    }
  }
}

p min, max

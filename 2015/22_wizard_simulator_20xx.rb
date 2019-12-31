BOSS_HP = 58
BOSS_DAMAGE = 9

INFINITY = 1.0 / 0

COSTS = {
  missile: 53,
  drain: 73,
  shield: 113,
  poison: 173,
  recharge: 229,
}

class Game
  def initialize(hard: false)
    @hero_hp = 50
    @hero_mp = 500
    @boss_hp = BOSS_HP
    @boss_damage = BOSS_DAMAGE
    @shield_timer = 0
    @poison_timer = 0
    @recharge_timer = 0
    @hard = hard
  end

  def to_i
    @hero_hp << 22 | @hero_mp << 16 | @boss_hp << 10 | @shield_timer << 7 | @poison_timer << 4 | @recharge_timer << 1 | (@hard ? 1 : 0)
  end

  def play(spell)
    cast(spell)
    return winner if winner

    tick
    return winner if winner

    boss_attack
    return winner if winner

    @hero_hp -= 1 if @hard

    tick
    winner
  end

  def spells
    s = COSTS.select { |_, m| m <= @hero_mp }
    s.delete(:shield)   if @shield_timer > 0
    s.delete(:poison)   if @poison_timer > 0
    s.delete(:recharge) if @recharge_timer > 0
    s
  end

  private

  def cast(spell)
    @hero_mp -= COSTS[spell]

    case spell
    when :missile   then @boss_hp -= 4
    when :drain     then @boss_hp -= 2; @hero_hp += 2
    when :shield    then @shield_timer = 6
    when :poison    then @poison_timer = 6
    when :recharge  then @recharge_timer = 5
    end
  end

  def boss_attack
    shield = @shield_timer > 0 ? 7 : 0
    @hero_hp -= [1, @boss_damage - shield].max
  end

  def tick
    @shield_timer -= 1 if @shield_timer > 0
    (@poison_timer -= 1; @boss_hp -= 3) if @poison_timer > 0
    (@recharge_timer -= 1; @hero_mp += 101) if @recharge_timer > 0
  end

  def winner
    return :boss if @hero_hp <= 0
    return :hero if @boss_hp <= 0
  end
end

@played = {}

def best(game, spells: [], cost: 0, turn: 1)
  if (c = @played[game.to_i]) && c <= cost
    return INFINITY
  end

  @played[game.to_i] = cost

  game.spells.map { |spell, mana|
    new_game = game.dup
    winner = new_game.play(spell)
    new_cost = cost + mana

    case winner
    when :boss
      INFINITY
    when :hero
      new_cost
    else
      best(new_game, spells: spells + [spell], cost: new_cost, turn: turn + 1)
    end
  }.min || INFINITY
end

p best(Game.new), best(Game.new(hard: true))

TEASPONS = 100
CALORIES = 500

max = 0
maxx = 0

TEASPONS.times { |a|
  (TEASPONS - a).times { |b|
    (TEASPONS - a - b).times { |c|
      d = TEASPONS - a - b - c
      capacity = (5 * a) + (-1 * b) + (-1 * d)
      durability = (-1 * a) + (3 * b) + (-1 * c)
      flavor = (4 * c)
      texture = (2 * d)
      cookie = [0, capacity].max * [0, durability].max * [0, flavor].max * [0, texture].max
      max = cookie if cookie > max
      maxx = cookie if cookie > maxx && (5 * a) + b + (6 * c) + (8 * d) == CALORIES
    }
  }
}

p max, maxx

__END__
Sprinkles: capacity 5, durability -1, flavor 0, texture 0, calories 5
PeanutButter: capacity -1, durability 3, flavor 0, texture 0, calories 1
Frosting: capacity 0, durability -1, flavor 4, texture 0, calories 6
Sugar: capacity -1, durability 0, flavor 0, texture 2, calories 8

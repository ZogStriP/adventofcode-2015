DISTANCE = 2503

reindeers = DATA.read.split("\n").map { |l|
  name, speed, duration, rest = /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+)/.match(l).captures
  r = [speed.to_i] * duration.to_i + [0] * rest.to_i
  [name, r * (DISTANCE / r.size + 1)]
}.to_h

p reindeers.values.map { |r| r[0..DISTANCE].sum }.max

dists = Hash.new(0)
points = Hash.new(0)

DISTANCE.times { |d|
  reindeers.each { |k, v| dists[k] += v[d] }
  reindeers.each { |k, _| points[k] += 1 if dists[k] == dists.values.max }
}

p points.values.max

__END__
Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds.
Rudolph can fly 3 km/s for 15 seconds, but then must rest for 28 seconds.
Donner can fly 19 km/s for 9 seconds, but then must rest for 164 seconds.
Blitzen can fly 19 km/s for 9 seconds, but then must rest for 158 seconds.
Comet can fly 13 km/s for 7 seconds, but then must rest for 82 seconds.
Cupid can fly 25 km/s for 6 seconds, but then must rest for 145 seconds.
Dasher can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
Dancer can fly 3 km/s for 16 seconds, but then must rest for 37 seconds.
Prancer can fly 25 km/s for 6 seconds, but then must rest for 143 seconds.

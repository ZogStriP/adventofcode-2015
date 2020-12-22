require "set"

decks = DATA.read.split("\n\n").map { _1.lines[1..].map(&:to_i) }

def combat(one, two)
  until one.empty? || two.empty?
    o, t = one.shift, two.shift
    o > t ? one << o << t : two << t << o
  end

  one.empty? ? two : one
end

def recursive_combat(one, two, first: false)
  return -1 if !first && one.max > two.max

  seen = Set.new

  loop {
    return first ? one : -1 unless seen.add?((one + [0] + two).pack("c*"))

    o, t = one.shift, two.shift

    winner = if one.size >= o && two.size >= t
      recursive_combat(one[...o], two[...t])
    else
      t <=> o
    end

    if winner < 0
      one << o << t
      return first ? one : -1 if two.empty?
    else
      two << t << o
      return first ? two :  1 if one.empty?
    end
  }
end

def score(deck)
  deck.reverse_each.with_index(1).sum { _1 * _2 }
end

p score combat(*decks.map(&:dup))
p score recursive_combat(*decks.map(&:dup), first: true)

__END__
Player 1:
43
21
2
20
36
31
32
37
38
26
48
47
17
16
42
12
45
19
23
14
50
44
29
34
1

Player 2:
40
24
49
10
22
35
28
46
7
41
15
5
39
33
11
8
3
18
4
13
6
25
30
27
9

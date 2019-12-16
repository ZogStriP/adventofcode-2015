signal  = DATA.read.strip.chars.map(&:to_i)
offset  = signal.take(7).join.to_i
message = (signal * 10_000).drop(offset)

def fft(s)
  s.size.times { |i|
    sum = [0, 0]
    len = i + 1

    (i..s.size).step(len * 2).each.with_index { |o, d|
      sum[d % 2] += s[o, len].sum
    }

    s[i] = (sum[0] - sum[1]).abs % 10
  }
end

100.times { fft(signal) }
puts signal.take(8).join

def fftt(s)
  (s.size - 1).downto(0).each { |i|
    s[i] = ((s[i + 1] || 0) + s[i]) % 10
  }
end

100.times { fftt(message) }
puts message.take(8).join

__END__
59793513516782374825915243993822865203688298721919339628274587775705006728427921751430533510981343323758576985437451867752936052153192753660463974146842169169504066730474876587016668826124639010922391218906707376662919204980583671961374243713362170277231101686574078221791965458164785925384486127508173239563372833776841606271237694768938831709136453354321708319835083666223956618272981294631469954624760620412170069396383335680428214399523030064601263676270903213996956414287336234682903859823675958155009987384202594409175930384736760416642456784909043049471828143167853096088824339425988907292558707480725410676823614387254696304038713756368483311

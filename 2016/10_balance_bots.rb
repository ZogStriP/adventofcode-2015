bots = Hash.new { |h, k| h[k] = [] }
lows = {}
highs = {}
outputs = {}

File.readlines("10.input").each { |line|
  case line
  when /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/
    lows[$1.to_i] = $3 + $2[0]
    highs[$1.to_i] = $5 + $4[0]
  when /value (\d+) goes to bot (\d+)/
    bots[$2.to_i] << $1.to_i
  end
}

changed = true

while changed
  changed = false

  bots.dup.each do |id, microchips|
    next unless microchips.size == 2
    low, high = microchips.sort
    puts id if low == 17 && high == 61
    lows[id]["b"] ? bots[lows[id].to_i] << low : outputs[lows[id].to_i] = low
    highs[id]["b"] ? bots[highs[id].to_i] << high : outputs[highs[id].to_i] = high
    bots[id] = []
    changed = true
  end
end

p (0..2).map { |o| outputs[o] }.reduce(:*)

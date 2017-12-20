require "set"

TARGET = "ORnPBPMgArCaCaCaSiThCaCaSiThCaCaPBSiRnFArRnFArCaCaSiThCaCaSiThCaCaCaCaCaCaSiRnFYFArSiRnMgArCaSiRnPTiTiBFYPBFArSiRnCaSiRnTiRnFArSiAlArPTiBPTiRnCaSiAlArCaPTiTiBPMgYFArPTiRnFArSiRnCaCaFArRnCaFArCaSiRnSiRnMgArFYCaSiRnMgArCaCaSiThPRnFArPBCaSiRnMgArCaCaSiThCaSiRnTiMgArFArSiThSiThCaCaSiRnMgArCaCaSiRnFArTiBPTiRnCaSiAlArCaPTiRnFArPBPBCaCaSiThCaPBSiThPRnFArSiThCaSiThCaSiThCaPTiBSiRnFYFArCaCaPRnFArPBCaCaPBSiRnTiRnFArCaPRnFArSiRnCaCaCaSiThCaRnCaFArYCaSiRnFArBCaCaCaSiThFArPBFArCaSiRnFArRnCaCaCaFArSiRnFArTiRnPMgArF"

transitions = {}

File.readlines("19.input").each do |line|
  from, to = line.scan(/(\w+) => (\w+)/).flatten
  transitions[from] ||= []
  transitions[from] << to
end

# Part 1
molecules = Set.new

transitions.each do |from, to|
  i = -1
  while i = TARGET.index(from, i + 1)
    to.each { |t| molecules << TARGET[0...i] + t + TARGET[(i + from.size)..-1] }
  end
end

p molecules.size

# Part 2
# https://www.reddit.com/r/adventofcode/comments/3xflz8/_19_solutions/cy4etju
elements = TARGET.scan(Regexp.union(transitions.keys)).size
y = TARGET.scan(/Y/).size

p elements - y - 1

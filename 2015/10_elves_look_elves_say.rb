look_and_say = -> (n) { n.gsub!(/(\d)\1*/) { |s| "#{s.size}#{s[0]}" } }

n = "1113122113"

40.times { look_and_say[n] }
p n.size

10.times { look_and_say[n] }
p n.size

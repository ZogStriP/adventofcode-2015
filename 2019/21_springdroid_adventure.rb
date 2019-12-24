PROGRAM = DATA.read.split(?,).map(&:to_i).freeze

class IntCode

  def initialize(mem)
    @pc = 0
    @base = 0
    @mem = mem.map.with_index { |m, i| [i, m] }.to_h
    @mem.default = 0
  end

  def read(address, mode)
    case mode.to_i
    when 0 then @mem[@mem[address]]
    when 1 then @mem[address]
    when 2 then @mem[@mem[address] + @base]
    end
  end

  def write(address, mode, value)
    case mode.to_i
    when 0 then @mem[@mem[address]] = value
    when 2 then @mem[@mem[address] + @base] = value
    end
  end

  def run(input)
    loop do
      mode, opcode = @mem[@pc].divmod(100)
      m = mode.digits
      a = read(@pc + 1, m[0])
      b = read(@pc + 2, m[1])

      case opcode
      when 1
        write(@pc + 3, m[2], a + b)
        @pc += 4
      when 2
        write(@pc + 3, m[2], a * b)
        @pc += 4
      when 3
        write(@pc + 1, m[0], input.shift)
        @pc += 2
      when 4
        @pc += 2
        return a if a > 255
      when 5
        a != 0 ? @pc = b : @pc += 3
      when 6
        a == 0 ? @pc = b : @pc += 3
      when 7
        write(@pc + 3, m[2], a < b ? 1 : 0)
        @pc += 4
      when 8
        write(@pc + 3, m[2], a == b ? 1 : 0)
        @pc += 4
      when 9
        @base += a
        @pc += 2
      when 99
        return
      else
        throw "Unknown opcode: #{opcode}"
      end
    end
  end

end

# ..............
# ..@...........
# ###ABCD#######

# !A || (!C && D)
walk = <<~SCRIPT
NOT C J
AND D J
NOT A T
OR T J
WALK
SCRIPT

p IntCode.new(PROGRAM).run(walk.bytes << 10)

# ..............
# ..@...........
# ###ABCDEFGHIJ.

# D && !(A && B && (C OR !H))
run = <<~SCRIPT
NOT H J
OR C J
AND A J
AND B J
NOT J J
AND D J
RUN
SCRIPT

p IntCode.new(PROGRAM).run(run.bytes << 10)

__END__
109,2050,21101,966,0,1,21101,0,13,0,1105,1,1378,21102,1,20,0,1105,1,1337,21101,0,27,0,1105,1,1279,1208,1,65,748,1005,748,73,1208,1,79,748,1005,748,110,1208,1,78,748,1005,748,132,1208,1,87,748,1005,748,169,1208,1,82,748,1005,748,239,21102,1,1041,1,21102,1,73,0,1106,0,1421,21102,78,1,1,21101,0,1041,2,21101,88,0,0,1106,0,1301,21101,0,68,1,21101,1041,0,2,21101,0,103,0,1106,0,1301,1102,1,1,750,1106,0,298,21102,82,1,1,21102,1,1041,2,21101,0,125,0,1106,0,1301,1102,1,2,750,1106,0,298,21101,79,0,1,21102,1041,1,2,21102,1,147,0,1106,0,1301,21101,84,0,1,21102,1,1041,2,21102,162,1,0,1106,0,1301,1101,0,3,750,1105,1,298,21102,1,65,1,21101,1041,0,2,21102,184,1,0,1105,1,1301,21102,76,1,1,21102,1,1041,2,21101,199,0,0,1105,1,1301,21102,75,1,1,21102,1,1041,2,21102,1,214,0,1105,1,1301,21101,221,0,0,1106,0,1337,21101,0,10,1,21101,1041,0,2,21102,1,236,0,1106,0,1301,1106,0,553,21101,0,85,1,21101,1041,0,2,21102,254,1,0,1105,1,1301,21101,78,0,1,21102,1,1041,2,21101,269,0,0,1106,0,1301,21102,276,1,0,1105,1,1337,21101,10,0,1,21102,1,1041,2,21102,291,1,0,1106,0,1301,1102,1,1,755,1105,1,553,21101,32,0,1,21101,0,1041,2,21102,1,313,0,1106,0,1301,21102,1,320,0,1105,1,1337,21101,0,327,0,1106,0,1279,2101,0,1,749,21101,65,0,2,21102,1,73,3,21102,346,1,0,1105,1,1889,1206,1,367,1007,749,69,748,1005,748,360,1101,0,1,756,1001,749,-64,751,1106,0,406,1008,749,74,748,1006,748,381,1101,-1,0,751,1106,0,406,1008,749,84,748,1006,748,395,1101,0,-2,751,1105,1,406,21101,0,1100,1,21102,406,1,0,1105,1,1421,21102,1,32,1,21102,1,1100,2,21101,421,0,0,1106,0,1301,21101,428,0,0,1105,1,1337,21102,435,1,0,1106,0,1279,2102,1,1,749,1008,749,74,748,1006,748,453,1102,1,-1,752,1106,0,478,1008,749,84,748,1006,748,467,1101,0,-2,752,1105,1,478,21102,1,1168,1,21102,1,478,0,1105,1,1421,21101,0,485,0,1105,1,1337,21102,10,1,1,21102,1168,1,2,21102,1,500,0,1106,0,1301,1007,920,15,748,1005,748,518,21102,1,1209,1,21101,518,0,0,1105,1,1421,1002,920,3,529,1001,529,921,529,1002,750,1,0,1001,529,1,537,102,1,751,0,1001,537,1,545,1001,752,0,0,1001,920,1,920,1105,1,13,1005,755,577,1006,756,570,21101,0,1100,1,21101,0,570,0,1106,0,1421,21102,1,987,1,1105,1,581,21101,0,1001,1,21101,588,0,0,1106,0,1378,1101,0,758,594,102,1,0,753,1006,753,654,20102,1,753,1,21102,610,1,0,1106,0,667,21102,0,1,1,21102,1,621,0,1105,1,1463,1205,1,647,21101,1015,0,1,21101,0,635,0,1106,0,1378,21102,1,1,1,21102,646,1,0,1106,0,1463,99,1001,594,1,594,1105,1,592,1006,755,664,1102,0,1,755,1106,0,647,4,754,99,109,2,1101,726,0,757,21201,-1,0,1,21102,9,1,2,21102,1,697,3,21101,0,692,0,1105,1,1913,109,-2,2105,1,0,109,2,101,0,757,706,2101,0,-1,0,1001,757,1,757,109,-2,2106,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,255,63,95,159,223,127,191,0,186,222,100,218,61,77,241,156,93,118,221,59,79,239,119,62,60,201,139,202,54,39,117,152,162,214,49,111,70,98,248,35,124,155,110,220,114,188,99,141,203,185,182,78,69,86,216,68,158,171,56,53,242,138,51,238,230,219,252,235,125,254,113,34,154,121,207,102,109,120,247,250,237,190,196,85,217,175,229,199,55,71,178,231,108,142,212,177,92,226,103,245,227,236,244,46,213,233,50,163,204,38,115,179,183,200,234,107,84,47,167,106,189,153,187,246,173,253,206,101,123,174,58,42,197,157,94,76,228,181,184,243,43,205,232,57,140,166,198,170,251,215,169,136,87,116,137,168,172,249,126,143,122,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,73,110,112,117,116,32,105,110,115,116,114,117,99,116,105,111,110,115,58,10,13,10,87,97,108,107,105,110,103,46,46,46,10,10,13,10,82,117,110,110,105,110,103,46,46,46,10,10,25,10,68,105,100,110,39,116,32,109,97,107,101,32,105,116,32,97,99,114,111,115,115,58,10,10,58,73,110,118,97,108,105,100,32,111,112,101,114,97,116,105,111,110,59,32,101,120,112,101,99,116,101,100,32,115,111,109,101,116,104,105,110,103,32,108,105,107,101,32,65,78,68,44,32,79,82,44,32,111,114,32,78,79,84,67,73,110,118,97,108,105,100,32,102,105,114,115,116,32,97,114,103,117,109,101,110,116,59,32,101,120,112,101,99,116,101,100,32,115,111,109,101,116,104,105,110,103,32,108,105,107,101,32,65,44,32,66,44,32,67,44,32,68,44,32,74,44,32,111,114,32,84,40,73,110,118,97,108,105,100,32,115,101,99,111,110,100,32,97,114,103,117,109,101,110,116,59,32,101,120,112,101,99,116,101,100,32,74,32,111,114,32,84,52,79,117,116,32,111,102,32,109,101,109,111,114,121,59,32,97,116,32,109,111,115,116,32,49,53,32,105,110,115,116,114,117,99,116,105,111,110,115,32,99,97,110,32,98,101,32,115,116,111,114,101,100,0,109,1,1005,1262,1270,3,1262,21002,1262,1,0,109,-1,2105,1,0,109,1,21102,1288,1,0,1106,0,1263,21001,1262,0,0,1101,0,0,1262,109,-1,2106,0,0,109,5,21102,1310,1,0,1106,0,1279,21202,1,1,-2,22208,-2,-4,-1,1205,-1,1332,22101,0,-3,1,21101,0,1332,0,1106,0,1421,109,-5,2106,0,0,109,2,21101,0,1346,0,1106,0,1263,21208,1,32,-1,1205,-1,1363,21208,1,9,-1,1205,-1,1363,1105,1,1373,21102,1,1370,0,1105,1,1279,1105,1,1339,109,-2,2105,1,0,109,5,1202,-4,1,1385,21001,0,0,-2,22101,1,-4,-4,21102,1,0,-3,22208,-3,-2,-1,1205,-1,1416,2201,-4,-3,1408,4,0,21201,-3,1,-3,1106,0,1396,109,-5,2105,1,0,109,2,104,10,21202,-1,1,1,21101,1436,0,0,1106,0,1378,104,10,99,109,-2,2105,1,0,109,3,20002,594,753,-1,22202,-1,-2,-1,201,-1,754,754,109,-3,2106,0,0,109,10,21101,0,5,-5,21101,0,1,-4,21101,0,0,-3,1206,-9,1555,21101,3,0,-6,21101,0,5,-7,22208,-7,-5,-8,1206,-8,1507,22208,-6,-4,-8,1206,-8,1507,104,64,1105,1,1529,1205,-6,1527,1201,-7,716,1515,21002,0,-11,-8,21201,-8,46,-8,204,-8,1105,1,1529,104,46,21201,-7,1,-7,21207,-7,22,-8,1205,-8,1488,104,10,21201,-6,-1,-6,21207,-6,0,-8,1206,-8,1484,104,10,21207,-4,1,-8,1206,-8,1569,21102,0,1,-9,1105,1,1689,21208,-5,21,-8,1206,-8,1583,21101,0,1,-9,1106,0,1689,1201,-5,716,1588,21002,0,1,-2,21208,-4,1,-1,22202,-2,-1,-1,1205,-2,1613,22102,1,-5,1,21101,1613,0,0,1105,1,1444,1206,-1,1634,22101,0,-5,1,21101,0,1627,0,1105,1,1694,1206,1,1634,21102,2,1,-3,22107,1,-4,-8,22201,-1,-8,-8,1206,-8,1649,21201,-5,1,-5,1206,-3,1663,21201,-3,-1,-3,21201,-4,1,-4,1105,1,1667,21201,-4,-1,-4,21208,-4,0,-1,1201,-5,716,1676,22002,0,-1,-1,1206,-1,1686,21102,1,1,-4,1105,1,1477,109,-10,2105,1,0,109,11,21102,1,0,-6,21102,0,1,-8,21102,1,0,-7,20208,-6,920,-9,1205,-9,1880,21202,-6,3,-9,1201,-9,921,1724,21002,0,1,-5,1001,1724,1,1733,20102,1,0,-4,22101,0,-4,1,21102,1,1,2,21101,9,0,3,21102,1754,1,0,1106,0,1889,1206,1,1772,2201,-10,-4,1767,1001,1767,716,1767,20101,0,0,-3,1105,1,1790,21208,-4,-1,-9,1206,-9,1786,22102,1,-8,-3,1105,1,1790,22101,0,-7,-3,1001,1733,1,1795,21002,0,1,-2,21208,-2,-1,-9,1206,-9,1812,21202,-8,1,-1,1106,0,1816,21202,-7,1,-1,21208,-5,1,-9,1205,-9,1837,21208,-5,2,-9,1205,-9,1844,21208,-3,0,-1,1106,0,1855,22202,-3,-1,-1,1106,0,1855,22201,-3,-1,-1,22107,0,-1,-1,1105,1,1855,21208,-2,-1,-9,1206,-9,1869,22101,0,-1,-8,1105,1,1873,22101,0,-1,-7,21201,-6,1,-6,1105,1,1708,21201,-8,0,-10,109,-11,2105,1,0,109,7,22207,-6,-5,-3,22207,-4,-6,-2,22201,-3,-2,-1,21208,-1,0,-6,109,-7,2106,0,0,0,109,5,1201,-2,0,1912,21207,-4,0,-1,1206,-1,1930,21102,0,1,-4,22101,0,-4,1,21201,-3,0,2,21101,0,1,3,21101,1949,0,0,1105,1,1954,109,-5,2105,1,0,109,6,21207,-4,1,-1,1206,-1,1977,22207,-5,-3,-1,1206,-1,1977,22102,1,-5,-5,1106,0,2045,22101,0,-5,1,21201,-4,-1,2,21202,-3,2,3,21101,1996,0,0,1105,1,1954,21202,1,1,-5,21102,1,1,-2,22207,-5,-3,-1,1206,-1,2015,21101,0,0,-2,22202,-3,-2,-3,22107,0,-4,-1,1206,-1,2037,21202,-2,1,1,21102,2037,1,0,106,0,1912,21202,-3,-1,-3,22201,-5,-3,-5,109,-6,2106,0,0

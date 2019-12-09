program = DATA.read.split(",").map(&:to_i)

class IntCode

  def initialize(mem, input: [])
    @pc = 0
    @mem = mem.dup
    @input = input
  end

  def read(address, mode)
    mode == 1 ? @mem[address] : @mem[@mem[address]]
  end

  def write(address, value)
    @mem[@mem[address]] = value
  end

  def run(input = nil)
    @input.push(input) if input

    loop do
      mode, opcode = @mem[@pc].divmod(100)
      m = mode.digits
      a = read(@pc + 1, m[0]) rescue nil
      b = read(@pc + 2, m[1]) rescue nil

      case opcode
      when 1
        write(@pc + 3, a + b)
        @pc += 4
      when 2
        write(@pc + 3, a * b)
        @pc += 4
      when 3
        write(@pc + 1, @input.shift)
        @pc += 2
      when 4
        @pc += 2
        return a
      when 5
        a != 0 ? @pc = b : @pc += 3
      when 6
        a == 0 ? @pc = b : @pc += 3
      when 7
        write(@pc + 3, a < b ? 1 : 0)
        @pc += 4
      when 8
        write(@pc + 3, a == b ? 1 : 0)
        @pc += 4
      when 99
        return
      end
    end
  end

end

p [*0..4].permutation.map { |settings|
  settings.reduce(0) { |signal, setting|
    IntCode.new(program, input: [setting]).run(signal)
  }
}.max

p [*5..9].permutation.map { |settings|
  vms = settings.map { |s| IntCode.new(program, input: [s]) }
  signal = 0
  while signal
    result = signal
    vms.each { |vm| signal = vm.run(signal) }
  end
  result
}.max

__END__
3,8,1001,8,10,8,105,1,0,0,21,34,55,68,93,106,187,268,349,430,99999,3,9,102,5,9,9,1001,9,2,9,4,9,99,3,9,1001,9,5,9,102,2,9,9,101,2,9,9,102,2,9,9,4,9,99,3,9,101,2,9,9,102,4,9,9,4,9,99,3,9,101,4,9,9,102,3,9,9,1001,9,2,9,102,4,9,9,1001,9,2,9,4,9,99,3,9,101,2,9,9,1002,9,5,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99

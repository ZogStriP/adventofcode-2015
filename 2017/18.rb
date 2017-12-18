def step(ops, regs, i, r, s)
  get = -> (v) { Integer === v ? v : regs[v] }

  case (op = ops[i])[0]
  when :set then regs[op[1]]  = get[op[2]]
  when :add then regs[op[1]] += get[op[2]]
  when :mul then regs[op[1]] *= get[op[2]]
  when :mod then regs[op[1]] %= get[op[2]]
  when :jgz then i += get[op[2]] - 1 if get[op[1]] > 0
  when :snd then s << get[op[1]]
  when :rcv
    return if r.empty? # wait
    regs[op[1]] = r.shift
  end

  i += 1
end

ops = DATA.readlines.map { |l| l.split.map { |v| v[/\d+/] ? v.to_i : v.to_sym } }

registers = [Hash.new(0), Hash.new(0)]
queues    = [[], []]
pointers  = [0, 0]
sent      = 0
first_rcv = nil

registers[1][:p] = 1

loop {

  loop {
    first_rcv ||= queues[1][-1] if ops[pointers[0]][0] == :rcv
    break unless p = step(ops, registers[0], pointers[0], queues[0], queues[1])
    pointers[0] = p
  }

  loop {
    sent += 1 if ops[pointers[1]][0] == :snd
    break unless p = step(ops, registers[1], pointers[1], queues[1], queues[0])
    pointers[1] = p
  }

  break if queues.all?(&:empty?)
}

p first_rcv, sent

__END__
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 464
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19

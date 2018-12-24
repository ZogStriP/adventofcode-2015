require "set"

seen = Set.new

def f(a)
  a |= 0x10000
  b = 14906355
  while a > 0
    b = (((b + (a & 0xFF)) & 0xFFFFFF) * 65899) & 0xFFFFFF
    a >>= 8
  end
  b
end

p n = f(0)

p loop {
  nn = f(n)
  break n unless seen.add?(nn)
  n = nn
}


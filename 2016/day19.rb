# https://en.wikipedia.org/wiki/Josephus_problem#k.3D2
def last_elf_next(n)
  2 * (n.to_s(2)[1..-1].to_i(2)) + 1
end

def last_elf_across(n, p = 1)
  p = 3 ** Math.log(n, 3).to_i
  p == n ? n : n - p + [n - 2 * p, 0].max
end

ELFS = 3004953
p last_elf_next(ELFS), last_elf_across(ELFS)

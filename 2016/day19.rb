def last_elf_next(elfs)
  (2..elfs).reduce(0) { |e, n| (e + 2) % n } + 1
end

def last_elf_across(elfs, e = 1)
  e *= 3 while e * 3 <= elfs
  e == elfs ? e : elfs - e + [elfs - 2 * e, 0].max
end

ELFS = 3004953
p last_elf_next(ELFS), last_elf_across(ELFS)

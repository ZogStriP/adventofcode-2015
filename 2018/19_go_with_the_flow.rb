def sum_of_factors(n)
  (1..n).select { |f| n % f == 0 }.sum
end

p sum_of_factors(948)
p sum_of_factors(10_551_348)

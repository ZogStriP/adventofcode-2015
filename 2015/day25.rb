require "openssl"

# Modular exponentiation FTW \0/
# https://en.wikipedia.org/wiki/Modular_exponentiation

ROW    = 3010
COLUMN = 3019
BASE   = 252533
MOD    = 33554393
EXP    = (ROW + COLUMN - 2) * (ROW + COLUMN - 1) / 2 + COLUMN - 1
RESULT = 20151125 * BASE.to_bn.mod_exp(EXP, MOD) % MOD

p RESULT.to_i

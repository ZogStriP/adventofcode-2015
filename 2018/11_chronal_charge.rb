SIZE   =  300
SERIAL = 6042

# https://en.wikipedia.org/wiki/Summed_area_table
@grid = Array.new(SIZE) { Array.new(SIZE, 0) }

(1...SIZE).each { |x|
  (1...SIZE).each { |y|
    power = ((((x + 10) * y + SERIAL) * (x + 10)).digits[2] || 0) - 5
    @grid[x][y] = power + @grid[x][y - 1] + @grid[x - 1][y] - @grid[x - 1][y - 1]
  }
}

def find_best_square(min_size, max_size = min_size)
  best_power = 0
  best_square = nil

  (min_size..max_size).each { |s|
    (s...SIZE).each { |x|
      (s...SIZE).each { |y|
        power = @grid[x][y] + @grid[x - s][y - s] - @grid[x - s][y] - @grid[x][y - s]
        if power > best_power
          best_power = power
          best_square = [x - s + 1, y - s + 1, s]
        end
      }
    }
  }

  best_square
end

p find_best_square(3)[0, 2]
p find_best_square(1, SIZE)

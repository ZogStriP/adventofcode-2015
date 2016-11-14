weights = File.readlines("day24.input").map(&:to_i).sort

@groups = 4
@sum = weights.reduce(:+) / @groups

def quantum(weights, groups)
  (1..weights.size).each do |s|
    # for each combination of 's' items in 'weights'
    weights.combination(s).each do |c|
      # we have a valid combination \o/
      if c.reduce(:+) == @sum
        # we've ended our search when there are 2 groups left
        return true if groups == 2
        # otherwise, we keep validating other groups
        return quantum(weights - c, groups - 1) if groups < @groups
        # return the quantum of the first valid partition we've found
        # this works because 'weights' is sorted and combination gives us the combinations in order
        return c.reduce(:*) if quantum(weights - c, groups - 1)
      end
    end
  end
end

p quantum(weights, @groups)

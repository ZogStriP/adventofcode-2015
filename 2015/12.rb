json = File.read("12.input").strip

# part 1
p json.scan(/-?\d+/).map(&:to_i).reduce(:+)

# part 2
def sum_non_reds(value)
  case value
  when Fixnum
    value
  when Array
    value.map { |v| sum_non_reds(v) }.inject(:+)
  when Hash
    value.has_value?("red") ? 0 : sum_non_reds(value.values)
  else
    0
  end
end

require "json"
p sum_non_reds JSON.parse(json)

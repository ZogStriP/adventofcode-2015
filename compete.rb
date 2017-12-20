#!/usr/bin/env ruby

fail "Missing or incorrect 'AOC_SESSION' env variable" if ENV["AOC_SESSION"]&.size != 96

require "tzinfo"

now = TZInfo::Timezone.get("EST").now
day = ARGV.size > 0 ? ARGV[0].to_i : now.day

fail "It's not that time of the year yet" unless now.month == 12 && (1..25) === day

def get(path)
  `curl -sS -H 'Cookie: session=#{ENV["AOC_SESSION"]}' 'http://adventofcode.com#{path}'`
end

puts "Retrieving problem name..."

name = get("/#{now.year}/day/#{day}")[/<h2>--- Day \d+: (.+) ---<\/h2>/, 1]
        .gsub(/\s+/, "_")
        .gsub(/_{2,}/, "_")
        .gsub(/^_+|_+$/, "")
        .downcase

require "fileutils"

FileUtils.mkdir_p now.year.to_s

filename = "%d/%02d_%s.rb" % [now.year, day, name]

if File.exists?(filename)
  print "Do you want to overwrite '#{filename}'? [Y/n] "
  exit if gets()[/n/i]
end

puts "Downloading input..."

input = get("/#{now.year}/day/#{day}/input")

puts "Creating '#{filename}'..."

code = <<~CODE
input = (ARGV.empty? ? DATA.read.strip : ARGV[0])

# TODO

__END__
#{input.strip}
CODE

IO.write(filename, code)

puts "Done!"

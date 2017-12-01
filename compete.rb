#!/usr/bin/env ruby

fail "Missing or incorrect 'AOC_SESSION' env variable" if ENV["AOC_SESSION"]&.size != 96

require "tzinfo"

now = TZInfo::Timezone.get("EST").now

fail "It's not that time of the year yet" unless now.month == 12 && (1..25) === now.day

require "fileutils"

FileUtils.mkdir_p now.year.to_s

filename = "%d/%02d.rb" % [now.year, now.day]

if File.exists?(filename)
  print "Do you want to overwrite '#{filename}'? [Y/n] "
  exit if gets()[/n/i]
end

puts "Downloading input..."

input = `curl -sS -H 'Cookie: session=#{ENV["AOC_SESSION"]}' 'http://adventofcode.com/#{now.year}/day/#{now.day}/input'`

puts "Creating '#{filename}'..."

code = <<~CODE
input = (ARGV.empty? ? DATA.read.strip : ARGV[0])

# TODO

__END__
#{input.strip}
CODE

IO.write(filename, code)

puts "Done!"

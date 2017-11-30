#!/usr/bin/env ruby

fail "Missing or incorrect 'AOC_SESSION' env variable" if ENV["AOC_SESSION"]&.size != 96

require "tzinfo"

now = TZInfo::Timezone.get("EST").now

fail "It's not that time of the year yet" unless now.month == 12 && (1..25) === now.day

require "fileutils"

FileUtils.mkdir_p now.year.to_s

filename = "%d/%02d" % [now.year, now.day]

puts "Downloading input to '#{filename}.input'..."

`curl -sS -H 'Cookie: session=#{ENV["AOC_SESSION"]}' 'https://adventofcode.com/#{now.year}/day/#{now.day}/input' -o '#{filename}.input'`

puts "Creating '#{filename}.rb'..."

`touch #{filename}.rb`

puts "Done!"

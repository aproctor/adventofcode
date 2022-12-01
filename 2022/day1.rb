#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/1

elfs = []
total_cals = 0

File.open('day1.data').each do |line|
  next if(line.nil?)
  md = line.match(/([0-9]+)/)
  if(!md.nil?)
    total_cals += md[1].to_i
  else
  	elfs << total_cals
  	total_cals = 0
  end
end

if total_cals > 0
	elfs << total_cals
end

elfs.sort!

p1 = elfs[-1]
puts "Part 1: #{p1} cals"

p2 = elfs[-1] + elfs[-2] + elfs[-3]
puts "Part 2: #{p2} cals"

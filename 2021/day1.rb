#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/1

increase_count = -1
prev_reading = 0
File.open('day1.data').each do |line|
  next if(line.nil?)
  val = line.to_i
  increase_count += 1 if val > prev_reading

  prev_reading = val
end

puts "Part 1: #{increase_count}"

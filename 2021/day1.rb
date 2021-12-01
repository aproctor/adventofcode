#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/1

increase_count = -1
prev_reading = 0
vals = []
File.open('day1.data').each do |line|
  next if(line.nil?)
  val = line.to_i  
  increase_count += 1 if val > prev_reading

  vals << val

  prev_reading = val
end

puts "Part 1: #{increase_count}"


# Part 2

prev_sum = 0
increase_count = -1
(2..vals.length-1).each do |i|
	sum = vals[i] + vals[i-1] + vals[i-2]
	increase_count += 1 if sum > prev_sum

	prev_sum = sum
end

puts "Part 2: #{increase_count}"
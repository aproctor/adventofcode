#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/10

#start with outlet (joltage = 0)
numbers = [0]
File.open('day10.data').each do |line|
  next if(line.nil?)
  md = line.match(/([0-9]+)/)
  if(!md.nil?)
    numbers << md[1].to_i
  end
end

numbers.sort!

# add device (highest joltage +3)
numbers << numbers[-1] + 3


puts "Part 1"
three_count = 0
one_count = 0
(0..numbers.length-2).each do |i|
	delta = numbers[i+1] - numbers[i]
	if(delta > 3)
		puts "Invalid sequence, can't continue from #{numbers[i]} to #{numbers[i+1]}"
	elsif(delta == 3)
		three_count += 1
	elsif(delta == 1)
		one_count += 1
	end
end
puts "#{three_count} 3-jolt jumps * #{one_count} 1-jolt jumps = #{three_count*one_count}"



# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

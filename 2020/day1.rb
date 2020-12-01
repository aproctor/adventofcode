#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/1

vals = []
File.open('day1.data').each do |line|
  next if(line.nil?)
  vals << line.to_i
end

product = 0
vals.each_with_index do |v1, i|
	vals.each_with_index do |v2, j|
		next if i == j

		if(v1 + v2 == 2020)
			product = v1 * v2
			break
		end
	end
end

puts "Part 1: #{product}"

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

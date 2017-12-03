#!/usr/bin/env ruby
# Day 3 2017
# See http://adventofcode.com/2017/day/3

puts "Day 3 Manhattan distance"


# 37  36  35  34  33  32  31
# 38  17  16  15  14  13  30
# 39  18   5   4   3  12  29
# 40  19   6   1   2  11  28
# 41  20   7   8   9  10  27
# 42  21  22  23  24  25  26
# 43  44  45  46  47  48  49
# Bottom left corners of every sized square = length^2

def part1(num)
	return 0 if(num <= 1)
	
	# Find the smallest dimension that < number to get co-ordinate of the corner (lenth / 2, length / 2)
	length = Math.sqrt(num).floor
	length = length - 1 if(length % 2 == 0) #we're looking for closest odd number square root, since our squres are 1,3,5,7 etc sized

	# walk around to find the co-ordinate of the number	
	x = (length / 2).floor
	y = x
	bounds = x + 1
	# puts "NUM: #{num} starting at (#{x},#{y})"

	if(length * length == num)
		#literal corner case, you're already at the co-ordinate
	else
		direction = :right
		(length*length+1..num).each do |i|
			if(direction == :right)
				x += 1
				direction = :up if x == bounds
			elsif(direction == :up)
				y -= 1
				direction = :left if y == -bounds
			elsif(direction == :left)
				x -= 1
				direction = :down if x == -bounds
			else #down
				y += 1
				direction = :right if y == bounds
			end
			# puts "#{i} (#{x},#{y})"
		end
	end

	distance = x.abs + y.abs

	puts "#{num}: #{distance}"

	distance
end

part1(12)
part1(23)
part1(1024)
part1(277678)
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

	puts "Part 1 - #{num}: #{distance}"

	distance
end

# Squares are valued in sequence, including all neighboring cells
# 147  142  133  122   59
# 304    5    4    2   57
# 330   10    1    1   54
# 351   11   23   25   26
# 362  747  806--->   ...

#Find the first value larger than num in this grid
def part2(num)
	return 1 if(num < 1)
	
	
	# walk around in a similar fashion to part 1, starting at (0,0)
	x = 0
	y = 0
	bounds = 1
	direction = :right
	known_values = {}
	known_values["0,0"] = 1
	last_value = 1

	#num is actually more of an arbirtrary limit on this loop, but the numbers grow so rapidly, it's for sure less than num spots away
	num.times do |i|

		# Move Pointer
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
			if y == bounds
				direction = :right
				bounds += 1
			end
		end

		# Evaluate known values of partners
		value = 0
		neighbours = [[x+1,y],[x+1,y-1],[x,y-1],[x-1,y-1],[x-1,y],[x-1,y+1],[x,y+1],[x+1,y+1]]
		neighbours.each do |pair|			
			key = pair.join(',')
			value += known_values[key].to_i # missing keys will return 0
		end
		#puts "#{i}: (#{x},#{y}) - #{value}"

		known_values["#{x},#{y}"] = value
		last_value = value


		break if(value > num)
	end
		
	puts "Part 2 - #{num}: #{last_value}"

	last_value
end




# part1(12)
# part1(23)
# part1(1024)
part1(277678)


# part2(30)
# part2(747)
part2(277678)
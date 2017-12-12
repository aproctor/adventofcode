#!/usr/bin/env ruby



def p1_twist_hash(inputs, size)
	# begin with a list of numbers from 0 to 255 (or size in this case)
	numbers = []
	size.times do |i|
		numbers << i
	end

 	#a current position which begins at 0
 	current_position = 0

	#a skip size (which starts at 0)
	skip_size = 0
	

	#a sequence of lengths (your puzzle input). Then, for each length:
	inputs.split(',').each do |length|
		#puts "current_position: #{current_position} length: #{length}"
		# Reverse the order of that length of elements in the list, starting with the element at the current position.
		stack = []
		end_pos = current_position+length.to_i-1
		(current_position..end_pos).each do |o|
			stack << numbers[o%numbers.length]
		end
		(current_position..end_pos).each do |o|
			numbers[o%numbers.length] = stack.pop
		end
		
		# Move the current position forward by that length plus the skip size.
		current_position += length.to_i + skip_size
		
		# Increase the skip size by one.
		skip_size += 1

		#puts numbers.inspect

	end


	numbers[0] * numbers[1]
end

def p2_twist_hash(inputs, size, iterations, seed)
	# begin with a list of numbers from 0 to 255 (or size in this case)
	numbers = []
	size.times do |i|
		numbers << i
	end

 	#a current position which begins at 0
 	current_position = 0

	#a skip size (which starts at 0)
	skip_size = 0

	lengths = []
	inputs.each_char do |c|
		lengths << c.ord
	end
	seed.each do |i|
		lengths << i
	end
	
	iterations.times do

		#a sequence of lengths (your puzzle input). Then, for each length:
		lengths.each do |length|
			#puts "current_position: #{current_position} length: #{length}"
			# Reverse the order of that length of elements in the list, starting with the element at the current position.
			stack = []
			end_pos = current_position+length.to_i-1
			(current_position..end_pos).each do |o|
				stack << numbers[o%numbers.length]
			end
			(current_position..end_pos).each do |o|
				numbers[o%numbers.length] = stack.pop
			end
			
			# Move the current position forward by that length plus the skip size.
			current_position += length.to_i + skip_size
			
			# Increase the skip size by one.
			skip_size += 1

			#puts numbers.inspect

		end

	end

	#convert numbers from sparse hash to dense hash
	dense_hash = []
	val = 0
	numbers.each_with_index do |n,i|		
		val = val ^ n
		if i % 16 == 15
			dense_hash[i/16.floor] = val
			val = 0			
		end
	end

	buffer = []
	dense_hash.each do |h|
		buffer << h.to_s(16).rjust(2,'0')
	end


	buffer.join('')
end

#puts p1_twist_hash("3,4,1,5",5)
puts "Part 1 - #{p1_twist_hash("129,154,49,198,200,133,97,254,41,6,2,1,255,0,191,108",256)}"

#puts p2_twist_hash("1,2,3",256, 1, [17, 31, 73, 47, 23])
#puts p2_twist_hash("",256, 64, [17, 31, 73, 47, 23])
#puts p2_twist_hash("AoC 2017",256, 64, [17, 31, 73, 47, 23])
#puts p2_twist_hash("1,2,3",256, 64, [17, 31, 73, 47, 23])
#puts p2_twist_hash("1,2,4",256, 64, [17, 31, 73, 47, 23])
puts p2_twist_hash("129,154,49,198,200,133,97,254,41,6,2,1,255,0,191,108",256, 64, [17, 31, 73, 47, 23])
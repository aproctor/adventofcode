#!/usr/bin/env ruby

require "set"

#########
# Day 10's Knot hash solution
#####

def knot_hash(inputs, size, iterations, seed)
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

#######
# Day 14's solution
####

# stpzcrnm

def bytes_to_bits(byte_string)
	return byte_string.hex.to_s(2).rjust(byte_string.size*4,'0')
end

def part1(input)
	puts "part1 - #{input}"
	checksum = 0

	128.times do |i|
		key = "#{input}-#{i}"
		hash = knot_hash(key,256, 64, [17, 31, 73, 47, 23])
		bits = bytes_to_bits(hash)

		#preview
		if(i < 5)
			puts bits[0..7].gsub('1','#').gsub('0','.')
		end

		checksum += bits.count('1')
	end

	return checksum
end

puts part1("flqrgnkx")
puts "\n"
puts part1("stpzcrnm")


def part2(input)
	puts "part2 - #{input}"
	checksum = 0

	occupied_spots = {}

	next_region = 1
	merges = 0

	128.times do |y|
		key = "#{input}-#{y}"
		hash = knot_hash(key,256, 64, [17, 31, 73, 47, 23])
		bits = bytes_to_bits(hash)

		bits.each_char.with_index do |c,x|
			if(c == "1")
				coord = "#{x},#{y}"

				left = occupied_spots["#{x-1},#{y}"]
				up = occupied_spots["#{x},#{y-1}"]
				region = nil

				if left
					if up
						#merge regions
						min = [left,up].min
						max = [left,up].max
						occupied_spots.each do |k,v|
							if occupied_spots[k] == max
								occupied_spots[k] = min
							end
						end
						region = min
						merges += 1
					else
						region = left
					end
				elsif up
					region = up
				else
					#no occupied adjacent region, define new region
					region = next_region
					next_region += 1
				end

				occupied_spots[coord] = region
			end
		end
	end

	#preview
	6.times do |y|
		line = []
		8.times do |x|
			region = occupied_spots["#{x},#{y}"]
			if region
				line << (region+48).chr
			else
				line << "."
			end
		end
		puts line.join('')
	end

	distinct = Set.new
	occupied_spots.each do |k,v|
		distinct << v
	end

	return distinct.size
end

puts "\n"
puts part2("flqrgnkx")
puts "\n"
puts part2("stpzcrnm")


#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/17


def part1(target, containers)
	matches = {}

	indexes = []
	containers.length.times do |i|
		indexes[i] = i
	end

	containers.length.times do |j|

		indexes.combination(j+1).each_with_index do |combo, i|
			# puts "#{j}: #{i}" if i % 1000000 == 0
			total = 0

			used = []
			combo.each do |bin|
				val = containers[bin]
				total += val
				used << "#{val}:#{bin}"
				break if total >= target
			end

			if(total == target) 
				# puts "Combo #{combo} -> using #{used} = #{target}"
				key = used.sort.join(',')
				matches[key] = used.length
			end	
		end
	end

	puts "#{matches.size} unique matches"
	min_used = 9999999
	matches.each do |k, v|
		min_used = v if v < min_used
	end

	puts "Min used: #{min_used}"
end

# part1(25, [20, 15, 10, 5, 5])
part1(150, [11, 30, 47, 31, 32, 36, 3, 1, 5, 3, 32, 36, 15, 11, 46, 26, 28, 1, 19, 3])

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

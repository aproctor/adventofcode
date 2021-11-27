#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/9

numbers = []
File.open('day9.data').each do |line|
  next if(line.nil?)
  md = line.match(/([0-9]+)/)
  if(!md.nil?)
    numbers << md[1].to_i
  end
end

def validate_sequence(numbers, preamble_length)
	#puts numbers.inspect
	
	numbers.each_with_index do |n, i|
		next if i < preamble_length

		#puts "Checking #{i}: #{n}"

		valid_number = false
		numbers[i-preamble_length..i-1].combination(2).each do |vals|
			if(vals[0] + vals[1] == n)
				#puts "Valid number: #{vals.inspect}"
				valid_number = true
				break
			end
		end

		if(!valid_number)
			puts "Invalid number: #{i}: #{n}"
			return n
		end		
	end

	return -1
end

def vulnerability(numbers, target)
	(0..numbers.length-2).each do |i|
		#puts "Trying #{i}"

		total_sum = numbers[i]
		min = max = numbers[i]
		(i+1..numbers.length-1).each do |j|
			total_sum += numbers[j]

			min = numbers[j] if numbers[j] < min
			max = numbers[j] if numbers[j] > max

			if(total_sum == target)
				puts "Target found starting at #{i} to #{j}"
				return min + max
			elsif total_sum > target
					#sequence can't equal target
					break
			end
		end
	end

	return -1;
end

puts "Part 1:"
invalid_number = validate_sequence(numbers, 25)

puts "\nPart 2:"
puts vulnerability(numbers, invalid_number)

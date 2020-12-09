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

	invalid_number_index = -1
	
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
			invalid_number_index = i
			break
		end		
	end

	if(invalid_number_index >= 0)
		return false
	else
		puts "Sequence is valid"
	end

	true
end

puts "Part 1:"
validate_sequence(numbers, 25)

#puts "\nPart 2:"
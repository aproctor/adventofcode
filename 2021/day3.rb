#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/3

numbers = []
File.open('day3.data').each do |line|
  next if line.nil? || line.strip.length == 0

  numbers << line.strip
end

puts "Part 1"

def bit_count(input)
	bit_counts = {}
	input.each do |line|
		line.each_char.with_index do |c, i|
		  	val = (c == "1") ? 1 : -1

		  	if !bit_counts.key?(i)
		  	  bit_counts[i] = val
		  	else
		  	  bit_counts[i] += val
		  	end
	  	end
	end

	bit_counts
end
bit_counts = bit_count(numbers)

bits = []
nbits = []
bit_counts.each do |k, v|
	bit = v > 0 ? 1 : 0
	nbit = bit == 1 ? 0 : 1
	# puts bit

	bits << bit
	nbits << nbit
end
# puts "Bits"
# puts bit_counts.inspect
gamma = bits.join('').to_i(2)
epsilon = nbits.join('').to_i(2)
puts "Gamma #{gamma}, Epsilon #{epsilon}, power consumption #{gamma * epsilon}"



puts "\nPart 2"

def part2_find_metric(input, metric)
	values = input
	max_iterations = input[0].length

	max_iterations.times do |i|
		bit_counts = bit_count(values)

		new_values = []
		values.each do |v|
			if metric == :oxygen
				target = bit_counts[i] < 0 ? "0" : "1"
			else
				target = bit_counts[i] < 0 ? "1" : "0"
			end

			if v[i] == target
				new_values << v
			end
		end
		
		values = new_values
		# puts "#{i}: #{values.inspect}"

		break if values.length <= 1
	end

	return values[0].to_i(2) if values.length == 1

	puts "Failure to reduce #{values.inspect}"	
	nil
end

oxygen = part2_find_metric(numbers, :oxygen)
carbon_dioxide = part2_find_metric(numbers, :carbon_dioxide)
puts "oxygen generator rating: #{oxygen}"
puts "CO2 scrubber rating: #{carbon_dioxide}"
puts "life support rating: #{oxygen * carbon_dioxide}"

#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/7

crabs = []
min_val = 999999
max_val = 0
File.open('day7.data').each do |line|
  next if(line.nil?)
  line.split(',').each do |v|
  	i = v.to_i
  	
  	crabs << i

  	min_val = i if i < min_val
  	max_val = i if i > max_val
  end
end

# puts "Crabs: #{crabs.join(',')}"
# sum = crabs.inject(0, :+)
# avg = sum / crabs.length
# puts "Average position: #{avg}"

puts "Part 1"
min_fuel_required = 999999
optimal_index = nil
(min_val .. max_val).each do |i|
	fuel_required = 0
	crabs.each do |n|
		fuel_required += (i - n).abs
	end

	if fuel_required < min_fuel_required
		optimal_index = i
		min_fuel_required = fuel_required
	end

	# puts "#{i}: #{fuel_required}"
end

puts "Optimal fuel required (#{min_fuel_required}) at position #{optimal_index}"



puts "\nPart 2"

def fuel_cost(delta, memo)
	return 0 if delta < 1
	return memo[delta] if memo.key?(delta)

	cost = fuel_cost(delta - 1, memo) + delta
	memo[delta] = cost

	cost
end

memo =  {}
memo[1] = 1

# puts fuel_cost((16 - 5).abs, memo)
# puts fuel_cost((1 - 5).abs, memo)
# puts fuel_cost((2 - 5).abs, memo)
# puts fuel_cost((0 - 5).abs, memo)
# puts fuel_cost((4 - 5).abs, memo)
# puts fuel_cost((2 - 5).abs, memo)
# puts fuel_cost((7 - 5).abs, memo)
# puts fuel_cost((1 - 5).abs, memo)
# puts fuel_cost((2 - 5).abs, memo)
# puts fuel_cost((14 - 5).abs, memo)

min_fuel_required = 99999999999
optimal_index = nil
(min_val .. max_val).each do |i|
	fuel_required = 0
	crabs.each do |n|
		fuel_required += fuel_cost((i - n).abs, memo)
	end

	if fuel_required < min_fuel_required
		optimal_index = i
		min_fuel_required = fuel_required
	end

	# puts "#{i}: #{fuel_required}"
end

puts "Optimal fuel required (#{min_fuel_required}) at position #{optimal_index}"
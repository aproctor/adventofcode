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

puts "Crabs: #{crabs.join(',')}"

# sum = crabs.inject(0, :+)
# avg = sum / crabs.length
# puts "Average position: #{avg}"

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

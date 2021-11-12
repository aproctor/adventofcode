#!/usr/bin/env ruby
# Day 12
# See https://adventofcode.com/2015/day/12

require 'json'

def recursive_sum_hash(obj)
	sum = 0
	obj.each do |k, v|
		if(v.is_a?(Array))
			sum += recursive_sum_array(v)
		elsif(v.is_a?(Hash))
			sum += recursive_sum_hash(v)
		else
			#non numeric will be 0
			sum += v.to_i
		end
	end

	sum
end

def recursive_sum_array(arr)
	sum = 0
	arr.each do |v|
		if(v.is_a?(Array))
			sum += recursive_sum_array(v)
		elsif(v.is_a?(Hash))
			sum += recursive_sum_hash(v)
		else
			#non numeric will be 0
			sum += v.to_i
		end
	end

	sum
end

file = File.read('./day12.data')
data_hash = JSON.parse(file)

s = recursive_sum_hash(data_hash)
puts "Sum: #{s}"
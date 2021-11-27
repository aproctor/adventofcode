#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/20

MAX_LOOP = 100000000

def all_factors(n)
	return [1] if n == 1

	factors = [1,n]

	mid_factor = Math.sqrt(n).floor
	(2..mid_factor).each do |i|
		if n % i == 0
			factors << i			

			# Add second factor, unless it's itself
			b = n/i
			factors << n/i if(i != b)
		end
	end

	factors
end

def present_score(house)
	total = 0	
	all_factors(house).each do |i|
		# puts " - #{i}"
		total += i*10
	end

	total
end

def part1(target_score)
	MAX_LOOP.times do |i|
		s = present_score(i+1)
		puts "House #{i+1} got #{s} presents."		

		return i+1 if(s >= target_score)
	end

	nil
end


# part1(150)
part1(36000000)
#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/20

MAX_LOOP = 1000000
elves = {}

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

def present_score(house, factor, limit=nil, elves=nil)
	total = 0
	all_factors(house).each do |i|
		# puts " - #{i}"
		if elves.nil? || limit.nil?
			total += i*factor
		else
			if elves.key?(i)
				elves[i] = elves[i] + 1
			else
				elves[i] = 1
			end

			total += i*factor if(elves[i] <= limit)
		end
	end

	total
end

def part1(target_score)
	MAX_LOOP.times do |i|
		s = present_score(i+1, 10)
		puts "House #{i+1} got #{s} presents."		

		return [i+1, s] if(s >= target_score)
	end

	nil
end

def part2(target_score)
	elves = {}
	MAX_LOOP.times do |i|
		s = present_score(i+1, 11, 50, elves)
		puts "House #{i+1} got #{s} presents."		

		return [i+1, s] if(s >= target_score)
	end

	nil
end


# part1(150)
# part1(36000000)
puts part2(36000000).inspect
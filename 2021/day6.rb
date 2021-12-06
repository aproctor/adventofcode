#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/6


def expand(days, fish, verbose=false)
	default_spawn_timer = 6
	new_spawn_timer = 8

	puts "Initial state:  #{fish.join(',')}" if verbose

	(1..days).each do |i|
		spawned_fish_count = 0
		fish.each_with_index do |f, i|
			new_val = f - 1
			if new_val < 0
				new_val = default_spawn_timer
				spawned_fish_count += 1
			end	

			fish[i]	= new_val
		end

		spawned_fish_count.times do
			fish << new_spawn_timer
		end

		puts "After #{i} days:\t#{fish.join(',')}" if verbose
	end

	fish.length
end

# puts expand(18, [3,4,3,1,2], true)
# puts expand(80, [3,4,3,1,2], false)

puts "Part 1"
puts expand(80, [1,1,1,1,3,1,4,1,4,1,1,2,5,2,5,1,1,1,4,3,1,4,1,1,1,1,1,1,1,2,1,2,4,1,1,1,1,1,1,1,3,1,1,5,1,1,2,1,5,1,1,1,1,1,1,1,1,4,3,1,1,1,2,1,1,5,2,1,1,1,1,4,5,1,1,2,4,1,1,1,5,1,1,1,1,5,1,3,1,1,4,2,1,5,1,2,1,1,1,1,1,3,3,1,5,1,1,1,1,3,1,1,1,4,1,1,1,4,1,4,3,1,1,1,4,1,2,1,1,1,2,1,1,1,1,5,1,1,3,5,1,1,5,2,1,1,1,1,1,4,4,1,1,2,1,1,1,4,1,1,1,1,5,3,1,1,1,5,1,1,1,4,1,4,1,1,1,5,1,1,3,2,2,1,1,1,4,1,3,1,1,1,2,1,3,1,1,1,1,4,1,1,1,1,2,1,4,1,1,1,1,1,4,1,1,2,4,2,1,2,3,1,3,1,1,2,1,1,1,3,1,1,3,1,1,4,1,3,1,1,2,1,1,1,4,1,1,3,1,1,5,1,1,3,1,1,1,1,5,1,1,1,1,1,2,3,4,1,1,1,1,1,2,1,1,1,1,1,1,1,3,2,2,1,3,5,1,1,4,4,1,3,4,1,2,4,1,1,3,1])
#!/usr/bin/env ruby

depths = {}
File.open('day13.data').each do |line|
	next if(line.nil?) 

	parts = line.split(': ')
	depths[parts[0].to_i] = parts[1].to_i
end

def p1_severity(depths)
	#Travel time is equal to the number of layers
	#which is the last depth key + 1
	serverity = 0
	num_ticks = depths.keys.last + 1
	num_ticks.times do |x|
		if(!depths[x].nil?)
			#firewall here, count the offset of the sentry and if it's at 0 you're caught
			patrol_length = depths[x] * 2 - 2
			if(x % patrol_length == 0)
				#caught, severity increased by depth * range
				puts "Caught! #{x} * #{depths[x]}"
				serverity += x * depths[x]
			end
		end
	end

	serverity
end

puts "Part 1 - #{p1_severity(depths)}"

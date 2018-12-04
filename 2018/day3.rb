#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/3


puts "Part 1 - overlaps"

claimedSquares = {}
File.open('day3.data').each do |line|
    next if(line.nil?)
	md = line.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)
	if(md) 
		id = md[1]
		x = md[2].to_i
		y = md[3].to_i
		w = md[4].to_i
		h = md[5].to_i
		
		w.times do |i|
			h.times do |j|
				claimedSquares["#{x+i},#{y+j}"] = claimedSquares["#{x+i},#{y+j}"].to_i + 1
			end
		end
	else
		puts "Unrecognized string: <#{input}>"
	end
end

overlap_count = 0
claimedSquares.each do |k,v|
	overlap_count += 1 if(v > 1)
end
puts "#{overlap_count} overlapping squares"
#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/3


puts "Part 1 - overlaps"

claimed_squares = {}
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
				claimed_squares["#{x+i},#{y+j}"] = claimed_squares["#{x+i},#{y+j}"].to_i + 1
			end
		end
	else
		puts "Unrecognized string: <#{input}>"
	end
end

overlap_count = 0
claimed_squares.each do |k,v|
	overlap_count += 1 if(v > 1)
end
puts "#{overlap_count} overlapping squares"

### Part 2

puts "Part 2 - unique overlaps"

claimed_squares = {}
valid_ids = []
File.open('day3.data').each do |line|
    next if(line.nil?)
	md = line.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)
	if(md) 
		id = md[1].to_i
		x = md[2].to_i
		y = md[3].to_i
		w = md[4].to_i
		h = md[5].to_i

		collisions = false		
		w.times do |i|
			h.times do |j|
				key = "#{x+i},#{y+j}"
				if(claimed_squares[key])
					collisions = true
					#remove other id
					valid_ids -= [claimed_squares[key]]
				else
					claimed_squares[key] = id
				end
			end
		end
		valid_ids << id if(!collisions)
	else
		puts "Unrecognized string: <#{input}>"
	end
end

puts "Valid claims #{valid_ids.inspect}"
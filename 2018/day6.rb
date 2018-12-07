#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/6

min_x = min_y = 999999
max_x = max_y = -1
points = []
idx = 'A'.ord
File.open('day6.data').each do |line|
  next if(line.nil? || line.strip.length == 0)
  
  coords = line.strip.split(', ').map do |i|
  	i.to_i
  end

  #test bounds
  min_x = coords[0] if coords[0] < min_x
  max_x = coords[0] if coords[0] > max_x
  min_y = coords[1] if coords[1] < min_y
  max_y = coords[1] if coords[1] > max_y

  points << {char: idx.chr, x: coords[0], y: coords[1], total: 0, valid: true}
  idx += 1
end


grid = {}
(min_x..max_x).each do |x|
	(min_y..max_y).each do |y|
		min_dist = 999999
		min_point = nil
		points.each do |p|
			dist = (p[:x] - x).abs + (p[:y] - y).abs
			if(dist < min_dist)
				min_dist = dist
				min_point = p
			elsif(dist == min_dist)
				#same distance, for now ignore both points maybe a smaller point will show up
				min_point = nil
			end
		end
		if(!min_point.nil?)
			min_point[:total] += 1

			#any point touching the bounds should be considered invalid for the result
			min_point[:valid] = false if(x == min_x || x == max_x || y == min_y || y == max_y)
		end
	end
end

max_val = 0
points.each do |p|
	# puts p.inspect
	max_val = p[:total] if p[:valid] && p[:total] > max_val
end
puts "Part 1 - #{max_val}"


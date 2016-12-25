#!/usr/bin/env ruby
# Day 24 2016
# See http://adventofcode.com/2016/day/24

#A cleaner implementation could be done (especially part 2), but i just grabbed this A* library
require "./ruby/pathfinding/version"
require "./ruby/pathfinding/path_finder"
require "./ruby/pathfinding/search_area"

puts "Advent of Code 2016 day 24"
PRINT_MAP = false

height = 0
width = 0

####
# Scan file once for dimensions
###
File.open('day24.data').each do |line|
  next if(line.nil?)

  height += 1
  width = line.length if(line.length > width)

  puts line if PRINT_MAP
end

####
# Build Pathfinding map
###
sa = Ruby::Pathfinding::SearchArea.new(width, height)
y = 0
origin = nil
targets = []
target_map = {}
File.open('day24.data').each do |line|	
  next if(line.nil?)

  x = 0
  line.each_char do |c|
  	if(c == "#")
  		sa.put_collision(x,y)
  	elsif(c == '0')
  		origin = [x,y]
  	elsif(c.ord > '0'.ord && c.ord <= '9'.ord)
  		targets << [x,y]
  		target_map["#{x},#{y}"] = c
  	end
  	x += 1
  end

  y += 1
end

#puts "O: #{origin.inspect}"
#puts "T: #{targets.inspect}"

def path_string(route,tmap)
	s = ""
	route.each do |r|
		s << tmap["#{r[0]},#{r[1]}"]
	end
	return s
end

####
# Find the shortest route through each point from each point
###
minimum_distance = 999999999
fastest_route = nil
targets.permutation.each do |route|	
	distance = 0
	long_route = false

	cur_point = Ruby::Pathfinding::Point.new(origin[0],origin[1])
	route.each do |p|
		destination = Ruby::Pathfinding::Point.new(p[0],p[1])
		pf = Ruby::Pathfinding::PathFinder.new(sa,cur_point,destination)
		path = pf.find_path
		if(path.nil?)
			#invalid path somehow
			puts "unable to find path!"
			break
		else						
			distance += path.length - 1
			# if(path_string(route, target_map) == "4123")
			# 	puts "- #{distance}"
			# 	path.each do |z|
			# 		puts "#{z.x},#{z.y}"
			# 	end
			# end
		end

		if(distance > minimum_distance)
			long_route = true
			break
		end

		cur_point = destination
	end

	puts "D: #{distance} L: #{long_route} R: #{path_string(route, target_map)}"
	if(long_route == false && distance < minimum_distance)
		minimum_distance = distance
		fastest_route = route
	end
end

puts "Minimum distance is #{minimum_distance}. #{path_string(fastest_route, target_map)}"


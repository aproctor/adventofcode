#!/usr/bin/env ruby
# Day 13 2016
# See http://adventofcode.com/2016/day/13
require "./ruby/pathfinding/version"
require "./ruby/pathfinding/path_finder"
require "./ruby/pathfinding/search_area"

puts "Advent of Code 2016 day 13"


#Part 1 - 
input = 1362
min_steps = 0

#build grid with padding
start_pos = [1,1]
target = [31,39]
grid_size = 50

grid = []
grid_size.times do |x|
  grid[x] = []  
  grid_size.times do |y|
    #based on spec, determin if it's open
    bits = ((x*x + 3*x + 2*x*y + y + y*y) + input).to_s(2).count("1")    
    grid[x][y] = (bits % 2 == 0) ? 0 : 1
  end  
end


#find shortest path using A*
sa = Ruby::Pathfinding::SearchArea.new(grid_size, grid_size)
start_loc = Ruby::Pathfinding::Point.new(1,1)
destination = Ruby::Pathfinding::Point.new(31,39)

grid_size.times do |x|
  grid_size.times do |y|
    if(grid[x][y] == 1)
      sa.put_collision(x,y)
    end
  end
end
pf = Ruby::Pathfinding::PathFinder.new(sa,start_loc,destination)

        
#pf.p_search_area
path = pf.find_path
#pf.p_search_area

puts "part 1 - #{path.length}"

#part 2 - distinct places within 50 paces
valid_location_count = 1
grid_size.times do |x|
  grid_size.times do |y|
    if(grid[x][y] == 0)
      destination = Ruby::Pathfinding::Point.new(x,y)
      pf = Ruby::Pathfinding::PathFinder.new(sa,start_loc,destination)
      path = pf.find_path
      if(!path.nil? && path.length <= 50)
        valid_location_count += 1
      end
    end
  end
end

puts "part 2 - valid locations within 50 paces #{valid_location_count}"
#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/1

puts "Advent of Code 2016 day 1"

cur_x = 0
cur_y = 0
direction = 0
#north = 0
#east = 1
#south = 2
#west = 3

known_locations = {}
first_double = nil

first_time_on_base_1 = -1
File.open('day1.data').each do |line|
  continue if(line.nil?)
  
  line.split(', ').each do |instruction|
    match = instruction.match(/(R|L)([0-9]+)/)
    if(!match.nil?)
      turn = match[1]
      moves = match[2].to_i

      #update direction
      if(turn == "R")
        direction += 1
      elsif (turn == "L")
        direction -= 1
      end
      direction = direction % 4

      moves.times do 
        if(direction == 0) #N
          cur_x += 1
        elsif(direction == 1) #E
          cur_y += 1
        elsif(direction == 2) #S
          cur_x -= 1
        else #W
          cur_y -= 1
        end

        key = "#{cur_x},#{cur_y}"      
        if(first_double.nil? && known_locations.key?(key))
          first_double = key
        end
        #any value will do, but we'll store distance because it's useful
        known_locations[key] = cur_x.abs + cur_y.abs

      end

      
      
    end

  end
end

d = cur_x.abs + cur_y.abs

puts "Final destination is #{cur_x},#{cur_y} #{d} blocks away"
puts "First double is #{first_double}. #{known_locations[first_double]} blocks away"




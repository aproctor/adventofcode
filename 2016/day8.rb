#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/8

puts "Advent of Code 2016 day 8"


#Part 1 - sum of sector ids

def draw_rect(w,h)
end

def rotate(type, offset, amount)
end

File.open('day8.data').each do |line|
  continue if(line.nil?)

  rect_instruction = /rect (\d+)x(\d+)/.match(line) 
  if(!rect_instruction.nil?)
    puts line
    draw_rect(rect_instruction[1],rect_instruction[2])
  else
    rotate_instruction = /rotate (row|column) (x|y)=(\d+) by (\d+)/.match(line) 
    if(!rotate_instruction.nil?)
      rotate(rotate_instruction[1].to_sym,rotate_instruction[3].to_i,rotate_instruction[4].to_i)
    end
  end
  

end

puts "done"
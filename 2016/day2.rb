#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/2

puts "Advent of Code 2016 day 2"

keypad = Array[
  [1,2,3],
  [4,5,6],
  [7,8,9]
]
cur_x = 1
cur_y = 1

code = []

File.open('day2.data').each do |line|
  continue if(line.nil?)
  
  line.each_char do |instruction|
    
    case instruction
    when 'U'
      cur_x -= 1
    when 'D'
      cur_x += 1
    when 'L'
      cur_y -= 1
    when 'R'
      cur_y += 1
    end

    #clamp values, not on latest ruby yet :(
    cur_x = [0, [cur_x, 2].min].max
    cur_y = [0, [cur_y, 2].min].max 
      
  end

  #puts "line1: #{cur_x},#{cur_y} - #{keypad[cur_y][cur_x]}"
  code.push(keypad[cur_y][cur_x])
end

puts "part 1 - code: #{code.join('')}"





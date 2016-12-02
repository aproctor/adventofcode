#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/2

puts "Advent of Code 2016 day 2"

part1_keypad = Array[
  [1,2,3],
  [4,5,6],
  [7,8,9]
]
part2_keypad = Array[
  [0,0,1,0,0],
  [0,2,3,4,0],
  [5,6,7,8,9],
  [0,'A','B','C',0],
  [0,0,'D',0,0]
]
keypad = part2_keypad
key_bounds = keypad.length - 1

cur_x = 0
cur_y = 2

code = []

File.open('day2.data').each do |line|
  continue if(line.nil?)

  line.each_char do |instruction|

    prev_x = cur_x
    prev_y = cur_y
    
    case instruction
    when 'U'
      cur_y -= 1
    when 'D'
      cur_y += 1
    when 'L'
      cur_x -= 1
    when 'R'
      cur_x += 1
    end

    #validate new x,y positions and maybe throw them away

    if(cur_x < 0 || cur_x > key_bounds || cur_y < 0 || cur_y > key_bounds || keypad[cur_y][cur_x] == 0)
      cur_x = prev_x
      cur_y = prev_y
    end
      
  end

  #puts "line1: #{cur_x},#{cur_y} - #{keypad[cur_y][cur_x]}"
  code.push(keypad[cur_y][cur_x])
end

puts "part 1 - code: #{code.join('')}"





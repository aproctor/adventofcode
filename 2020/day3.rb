#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/3

cur_pos = 0
x_vel = 3
tree_count = 0

File.open('day3.data').each do |line|
  next if(line.nil?)
  i = cur_pos % (line.length - 1) # ignore \n

  x = line[i]
  if(x == "#")
  	line[i] = "X"
  	tree_count += 1
  else
  	line[i] = "O"
  end
  puts line


  #move for next line
  cur_pos += x_vel
end

puts "Trees hit: #{tree_count}"

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

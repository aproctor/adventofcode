#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/3

def trees_hit(x_vel, y_vel)
	cur_pos = 0
	tree_count = 0

	cur_row = 0

	File.open('day3.data').each do |line|
	  next if(line.nil?)

	  if(cur_row % y_vel == 0)
		  i = cur_pos % (line.length - 1) # ignore \n

		  x = line[i]
		  if(x == "#")
		  	line[i] = "X"
		  	tree_count += 1
		  else
		  	line[i] = "O"
		  end
		  # puts line

		  cur_pos += x_vel
		end

	  cur_row += 1
	end
	tree_count
end

puts "Part 1:"
puts "Trees hit: #{trees_hit(3,1)}"

puts "\nPart 2:"
product = trees_hit(1,1) * trees_hit(3,1) * trees_hit(5,1) * trees_hit(7,1) * trees_hit(1,2)
puts "Product: #{product}"

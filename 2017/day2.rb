#!/usr/bin/env ruby
# Day 2 2017
# See http://adventofcode.com/2017/day/2


def p1_row_val(row)
	max, min = nil
	row.gsub(/\s+/m, ' ').strip.split(" ").each_with_index do |val, i|
		num = val.to_i
		max = num if(i == 0 || max < num)
		min = num if(i == 0 || min > num)
	end
	#puts "#{row}: #{max-min}"

	max-min
end


# p1_row_val("5	1	9	5")
# p1_row_val("7 5 3")
# p1_row_val("2 4 6 8")

p1_checksum = 0
File.open('day2.data').each do |line|
  continue if(line.nil?)

  
  p1_checksum += p1_row_val(line)
end

puts "Part 1: #{p1_checksum}"
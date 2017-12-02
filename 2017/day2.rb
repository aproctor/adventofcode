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

def p2_row_val(row)
	max, min = nil
	values = []
	row.gsub(/\s+/m, ' ').strip.split(" ").each_with_index do |val, i|
		values << val.to_i
	end

	#n*2 algo to start
	values.each_with_index do |v1, i|
		values.each_with_index do |v2, j|	
			if(i != j && v1 % v2 == 0)
				min, max = [v1,v2].sort
				# puts "#{min}, #{max} #{max/min}"
				return max / min
			end
		end
	end

	#no value found
	0 
end


# p1_row_val("5	1	9	5")
# p1_row_val("7 5 3")
# p1_row_val("2 4 6 8")

# p2_row_val("5 9 2 8")
# p2_row_val("9 4 7 3")
# p2_row_val("3 8 6 5")

p1_checksum = 0
p2_checksum = 0
File.open('day2.data').each do |line|
  continue if(line.nil?)

  
  p1_checksum += p1_row_val(line)
  p2_checksum += p2_row_val(line)
end

puts "Part 1: #{p1_checksum}"
puts "Part 2: #{p2_checksum}"
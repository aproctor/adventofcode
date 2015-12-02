#!/usr/bin/env ruby
# Day 2
# See http://adventofcode.com/day/2

total_paper_area = 0
total_ribbon = 0
File.open('day2.data').each do |line|
  dimensions = line.split('x').map(&:to_i).sort()

  total_paper_area += 3*dimensions[0]*dimensions[1] + 2*dimensions[1]*dimensions[2] + 2*dimensions[0]*dimensions[2]
  total_ribbon += 2*dimensions[0] + 2*dimensions[1] + dimensions[0]*dimensions[1]*dimensions[2]
end

puts "Part 1 - total paper #{total_paper_area}"
puts "Part 2 - total ribbon #{total_ribbon}"



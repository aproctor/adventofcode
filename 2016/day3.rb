#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/3

puts "Advent of Code 2016 day 3"

valid = 0

File.open('day3.data').each do |line|
  continue if(line.nil?)

  #split data into side numbers
  md = /(\d+)\s+(\d+)\s+(\d+)/.match(line)    
  if(!md.nil? && md.length)    
    a = md[1].to_i
    b = md[2].to_i
    c = md[3].to_i

    if(a+b > c && a+c > b && b + c > a)
      valid += 1
    end
  end
 
end

puts "part1 valid triangles = #{valid}"







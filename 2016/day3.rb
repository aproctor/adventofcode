#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/3

puts "Advent of Code 2016 day 3"

valid = 0
p2valid = 0

def is_valid_triangle?(sides)
  a = sides[0]
  b = sides[1]
  c = sides[2]

  if (a+b > c && a+c > b && b + c > a)
    return true
  end
  
  return false  
end



#Part 1
File.open('day3.data').each do |line|
  continue if(line.nil?)

  #split data into side numbers
  md = /(\d+)\s+(\d+)\s+(\d+)/.match(line)    
  if(!md.nil? && md.length)    
    sides = [md[1].to_i, md[2].to_i, md[3].to_i]

    if(is_valid_triangle?(sides))
      valid += 1
    end
  end
 
end

puts "part1 valid triangles = #{valid}"


#Part 2 - columns
col1 = []
col2 = []
col3 = []

File.open('day3.data').each do |line|
  continue if(line.nil?)


  #split data into side numbers
  md = /(\d+)\s+(\d+)\s+(\d+)/.match(line)    
  if(!md.nil? && md.length)
    col1.push(md[1].to_i)
    col2.push(md[2].to_i)
    col3.push(md[3].to_i)

    if(col1.length == 3)
      #validate columns      
      p2valid += 1 if(is_valid_triangle?(col1))
      p2valid += 1 if(is_valid_triangle?(col2))
      p2valid += 1 if(is_valid_triangle?(col3))

      col1 = []
      col2 = []
      col3 = []
    end
  end
 
end

puts "part2 valid triangles = #{p2valid}"





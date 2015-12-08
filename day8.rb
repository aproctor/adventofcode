#!/usr/bin/env ruby
# Day 8
# See http://adventofcode.com/day/8

char_count = 0
non_escaped_char_count = 0

File.open('day8.data').each do |line|
  continue if(line.nil?)

  init_char_count = char_count

  line.each_char do |c|
    char_count += 1
  end

  #each line has an extra \n at the end in our data file
  char_count -= 1

  #Eval is evil, but whatevs
  evalString = eval(line)
  non_escaped_char_count += evalString.length

end


puts "======================="
puts "Part 1"
puts "======================="
puts "char_count: #{char_count}"
puts "non_escaped_char_count: #{non_escaped_char_count}"
puts "Result: #{char_count - non_escaped_char_count}"


#!/usr/bin/env ruby
# Day 5 2017
# See http://adventofcode.com/2017/day/5

p1_num_instructions = 0
p1_instructions = []
File.open('day5.data').each do |line|
  continue if(line.nil?)  

  p1_instructions << line.to_i
end

#Part 1
MAX_ITERATIONS = 1000000
cur_offset = 0
MAX_ITERATIONS.times do |i|
  if(cur_offset < 0 || cur_offset >= p1_instructions.length)
    puts "Part 1 - #{i} instructions"
    break
  end

  jump = p1_instructions[cur_offset]
  p1_instructions[cur_offset] += 1

  cur_offset += jump
end

puts "Done"
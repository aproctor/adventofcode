#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/6

#MAX_ITERATIONS = 1000000 #NASA required saftey on while loops

input = nil
File.open('day6.data').each do |line|
  next if(line.nil?)
  input = line
end


puts input

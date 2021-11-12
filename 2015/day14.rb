#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/14

File.open('day14.data').each do |line|
  next if(line.nil?)
  md = line.match(/day ([0-9]+)/)
  if(!md.nil?)
    puts md[1]
  end
end

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

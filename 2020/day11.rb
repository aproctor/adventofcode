#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/11

data = []

File.open('day11.data').each do |line|
  next if(line.nil?)
  md = line.match(/([L\.]+)/)
  if(!md.nil?)
  	row = md[1].strip.split("")
  	data << row
  end
end

puts data.inspect
puts data.length

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/1

def fuel_level(mass)
  (mass / 3).floor - 2
end

# puts fuel_level(12)
# puts fuel_level(14)
# puts fuel_level(1969)
# puts fuel_level(100756)

total_fuel = 0
File.open('day1.data').each do |line|
  next if(line.nil?)
  
  total_fuel += fuel_level(line.to_i)
end
puts "Total fuel: #{total_fuel}"

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

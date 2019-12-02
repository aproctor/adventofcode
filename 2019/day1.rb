#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/1

def p1_fuel_level(mass)
  (mass / 3).floor - 2
end

def p2_fuel_level(mass)
  return 0 if(mass <= 0)

  fuel = [(mass / 3).floor - 2,0].max
  return fuel + p2_fuel_level(fuel)
end

# puts p1_fuel_level(12)
# puts p1_fuel_level(14)
# puts p1_fuel_level(1969)
# puts p1_fuel_level(100756)

# puts p2_fuel_level(14)
# puts p2_fuel_level(1969)
# puts p2_fuel_level(100756)

p1_total_fuel = 0
p2_total_fuel = 0
File.open('day1.data').each do |line|
  next if(line.nil?)
  
  p1_total_fuel += p1_fuel_level(line.to_i)
  p2_total_fuel += p2_fuel_level(line.to_i)
end
puts "P1 fuel: #{p1_total_fuel}"
puts "P2 fuel: #{p2_total_fuel}"

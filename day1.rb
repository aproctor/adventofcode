#!/usr/bin/env ruby
# Day 1
# See http://adventofcode.com/day/1

BASEMENT_1 = -1
current_floor = 0
num_instructions = 0

first_time_on_base_1 = -1
File.open('day1.data').each do |line|
  if(line.nil?)
    puts "what?"
    continue
  end
  line.each_char do |c|
    num_instructions += 1
    if(c == '(')
      current_floor += 1
    elsif(c == ')')
      current_floor -= 1
    end

    if(current_floor == BASEMENT_1 && first_time_on_base_1 < 0)
      first_time_on_base_1 = num_instructions
    end
  end
end

puts "Last floor: #{current_floor}"
puts "First time in basement: #{first_time_on_base_1}"

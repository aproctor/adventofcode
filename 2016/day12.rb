#!/usr/bin/env ruby
# Day 12 2016
# See http://adventofcode.com/2016/day/2

puts "Advent of Code 2016 day 12"

registers = {}

def value_of(key, registers)
  if(registers.key?(key))
    return registers[key] 
  end

  return key.to_i
end



#Part 1
instructions = []
cur_instruction = 0

File.open('day12.data').each do |line|
  continue if(line.nil?)

  instructions << line.split(' ')
end

cur_instruction = 0
while(cur_instruction < instructions.length)
  #just for safety, check outer bounds
  if(cur_instruction < 0)
    puts "WTF way out of bounds"
    break;
  end

  command = instructions[cur_instruction]
  if(command[0] == "jnz" && value_of(command[1], registers) != 0)
    #jump
    cur_instruction += value_of(command[2], registers)
  else
    if(command[0] == "cpy")
      registers[command[2]] = value_of(command[1], registers)
    elsif(command[0] == "inc")
      registers[command[1]] = registers[command[1]] + 1
    elsif(command[0] == "dec")
      registers[command[1]] = registers[command[1]] - 1
    end

    cur_instruction += 1
  end
end

puts "Part 1 #{registers.inspect}"


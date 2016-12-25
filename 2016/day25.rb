#!/usr/bin/env ruby
# Day 12 2016
# See http://adventofcode.com/2016/day/2

puts "Advent of Code 2016 day 12"

def value_of(key, registers)
  if(registers.key?(key))
    return registers[key] 
  end

  return key.to_i
end



#Part 1
instructions = []
cur_instruction = 0

File.open('day25.data').each do |line|
  next if(line.nil?)
  instructions << line.strip.split(' ')
  #puts line
end


MAX_TICKS = 100
MAX_ITERATIONS = 370

x = 0
while(x < MAX_ITERATIONS) do
  registers = {}
  registers['a'] = x
  cur_instruction = 0

  ticks = 0
  previous = nil
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
      elsif(command[0] == "mul")  
        registers[command[1]] = registers[command[1]] * value_of(command[2], registers)
      elsif(command[0] == "add")  
        registers[command[1]] = registers[command[1]] + value_of(command[2], registers)
      elsif(command[0] == "out")      
        next_val = value_of(command[1], registers)        
        if(previous == next_val)
          break
        end
        previous = next_val
        ticks += 1
      end

      cur_instruction += 1
    end

    break if(ticks > MAX_TICKS)  
  end

  puts "#{x}: #{ticks}" if ticks > 4

  x += 1
end

puts "Part 1 - #{x} had #{ticks} ticks"


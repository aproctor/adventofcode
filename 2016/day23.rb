#!/usr/bin/env ruby
# Day 23 2016
# See http://adventofcode.com/2016/day/23

puts "Advent of Code 2016 day 23"

registers = {}

def value_of(key, registers)
  if(registers.key?(key))
    return registers[key] 
  end

  return key.to_i
end

def valid_register?(target)
  return (target.ord >= 'a'.ord)
end



#Part 1
instructions = []
cur_instruction = 0

File.open('day23.data').each do |line|
  next if(line.nil?)

  instructions << {instruction: line.split(' '), toggled: false}
end

ticks = 0
cur_instruction = 0
while(cur_instruction < instructions.length)
  ticks += 1

  #just for safety, check outer bounds
  if(cur_instruction < 0)
    puts "WTF way out of bounds"
    break;
  end

  command = instructions[cur_instruction][:instruction]

  if(instructions[cur_instruction][:toggled])
    command = command.dup
    if(command[0] == "inc")
      command[0] = "dec"
    elsif(command[0] == "dec" || command[0] == "tgl")
      command[0] = "inc"
    elsif(command[0] == "jnz")
      command[0] = "cpy"
    elsif(command[0] == "cpy")
      command[0] = "jnz"
    end
  end

  puts "#{ticks} #{registers}" if ticks % 1000000 == 0

  if(command[0] == "jnz" && value_of(command[1], registers) != 0)
    #jump
    #puts "JUMP: #{cur_instruction} #{command.join('')} #{registers.inspect}" if(cur_instruction > 10)
    cur_instruction += value_of(command[2], registers)
  else
    if(command[0] == "cpy")
      if(valid_register?(command[2]))
        registers[command[2]] = value_of(command[1], registers)
      end
    elsif(command[0] == "inc")
      registers[command[1]] = registers[command[1]] + 1
    elsif(command[0] == "dec")
      registers[command[1]] = registers[command[1]] - 1
    elsif(command[0] == "tgl")
      offset = value_of(command[1], registers)
      t_offset = cur_instruction + offset
      if(t_offset >= 0 && t_offset < instructions.length)
        other_instruction = instructions[t_offset]
        other_instruction[:toggled] = !other_instruction[:toggled]
      end
    elsif(command[0] == "mul")
      registers[command[1]] = registers[command[1]] * value_of(command[2], registers)
    end

    cur_instruction += 1
  end
end

puts "Part 1 #{registers.inspect}"



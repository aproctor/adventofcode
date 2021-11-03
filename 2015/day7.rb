#!/usr/bin/env ruby
# Day 1 2015
# See http://adventofcode.com/2015/day/7

puts "Advent of Code 2015 day 7"


# Input example
#
# 123 -> x
# 456 -> y
# x AND y -> d
# x OR y -> e
# x LSHIFT 2 -> f
# y RSHIFT 2 -> g
# NOT x -> h
# NOT y -> i


def value_of(val, reg)
  return reg[val] if(reg.key?(val))

  val.to_i
end

def not_16bit(val)
  #Ruby doens't have 16-bit integers so we can't just use the ~ operator
  bit_string = val.to_s(2).rjust(16,"0")
  return_value = 0

  #puts "Value: #{val}"
  #puts "Bits: #{bit_string}"

  # Flipping the bits
  bit_string.each_char.with_index do |c, i|
    if c == '0'
      return_value += 2 ** (15 - i)
    end
  end

  #puts "Rval: #{return_value.to_s(2).rjust(16,'0')}"

  return_value
end

registers = {}
File.open('day7.data').each do |line|
  next if(line.nil?)

  #overly complex regex for validation
  md = line.strip.match(/^((NOT )?([a-z]*[0-9]*)|([a-z]*[01]*) AND ([a-z]*[01]*)|([a-z]*[01]*) OR ([a-z]*[01]*)|([a-z]+) ([LR]SHIFT) ([0-9]+)) -> ([a-z]+)$/)
  valid = true
  if(md.nil?)
    puts "no - #{line}"
    valid = false
  end  
  exit -1 if !valid

  command = line.strip.split(" -> ")
  ouput = command[1]
  input = command[0].split(" ")

  #puts input.inspect
  value = nil

  if input.length == 1
    # 123
    # x
    value = value_of(input[0], registers)
  elsif input.length == 2
    # NOT x
    value = not_16bit(value_of(input[1], registers))
  elsif input.length == 3
    # x AND y
    # x OR y
    # x LSHIFT 2
    # y RSHIFT 2
    if(input[1] == "AND")
      value = value_of(input[0], registers) & value_of(input[2], registers)
    elsif(input[1] == "OR")
      value = value_of(input[0], registers) | value_of(input[2], registers)
    elsif(input[1] == "LSHIFT")
      value = value_of(input[0], registers) << input[2].to_i
    elsif(input[1] == "RSHIFT")
      value = value_of(input[0], registers) >> input[2].to_i
    end    
  end
  if(!value.nil?)
    #puts "#{value} -> #{ouput}"
    registers[ouput] = value
  end 
end
puts "Registers: \n#{registers.inspect}"

puts "Part 1: #{registers['a']}"

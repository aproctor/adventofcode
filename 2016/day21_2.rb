#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/21
key = "fbgdceah"
puts "Advent of Code 2016 day 21 - #{key}"

#This was brute forced by running each possible index and finding they had unique results
DEROTATE_OFFSETS = [1,3,5,7,2,4,6,0]

def swap_positions(key, p1, p2)
  t = key[p1]
  key[p1] = key[p2]
  key[p2] = t

  return key
end

def swap_letters(key, l1, l2)
  i = 0
  key.each_char do |c|
    key[i] = l2 if(c == l1)
    key[i] = l1 if(c == l2)
    i += 1
  end

  return key
end

def move_positions(key, p2, p1)
  s = key.dup
  c = s.slice!(p1)

  if(p2 >= s.length)
    return s + c
  end
  return s.insert(p2, c)
end

def reverse_letters(key, p1, p2)
  buffer = []
  if(p1 > 0)
    buffer << key[0..p1-1]
  end
  buffer << key[p1..p2].reverse
  if(p2 < key.length - 1)
    buffer << key[p2+1..-1]
  end

  return buffer.join('')
end

def rotate_letters(key, direction, steps)
  steps = steps % key.length

  return key if(steps == 0)

  if(direction == :right)
    return key[steps..-1] + key[0..steps-1]
  end

  return key[-steps..-1] + key[0..-steps-1]  
end

def rotate_by_index_of_char(key, c)
  current_index = key.index(c)
  steps = current_index - DEROTATE_OFFSETS.index(current_index)
  direction = (steps > 0) ? :right : :left
  
  return rotate_letters(key, direction, steps.abs)
end

stack = []
File.open('day21.data').each do |line|
  next if(line.nil?)
  stack.push(line)
end

while(!stack.empty?) do 
  line = stack.pop()

  spi = /swap position (\d+) with position (\d+)/.match(line) 
  if(!spi.nil?)
    key = swap_positions(key, spi[1].to_i, spi[2].to_i)
  end
  sli = /swap letter ([[:alpha:]]) with letter ([[:alpha:]])/.match(line) 
  if(!sli.nil?)
    key = swap_letters(key, sli[1], sli[2])
  end

  ri = /reverse positions (\d+) through (\d+)/.match(line)
  if(!ri.nil?)
    key = reverse_letters(key, ri[1].to_i, ri[2].to_i)
  end

  roti = /rotate (left|right) (\d+) steps?/.match(line)
  if(!roti.nil?)
    key = rotate_letters(key, roti[1].to_sym, roti[2].to_i)
  end

  rpi = /rotate based on position of letter (\w)/.match(line)
  if(!rpi.nil?)
    key = rotate_by_index_of_char(key, rpi[1])
  end

  mpi = /move position (\d+) to position (\d+)/.match(line)
  if(!mpi.nil?)
    key = move_positions(key, mpi[1].to_i, mpi[2].to_i)
  end


  #puts "#{key} - #{line}"
end
#puts "#{key}"

puts "Part 2 - #{key}"


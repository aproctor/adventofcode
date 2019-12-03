#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/2

#no infinite loops in NASA, same safety for Santa in space
MAX_ITERATIONS = 100000
STOP_CMD = 99
ADD_CMD = 1
MUL_CMD = 2

def intcode(buffer)
  # buffer = input.split(',').map(&:to_i)  

  i = 0
  MAX_ITERATIONS.times do
    break if i >= buffer.count || buffer[i] == STOP_CMD

    cmd, v1, v2, t = buffer[i..i+3]
    if(cmd == ADD_CMD)
      buffer[t] = buffer[v1] + buffer[v2]
    elsif(cmd == MUL_CMD)
      buffer[t] = buffer[v1] * buffer[v2]
    else
      puts "unknown command at #{i} -> #{cmd}"
    end

    i += 4
  end

  # puts "= #{buffer.join(',')}"

  buffer[0]
end

def solve(noun, verb, data)
  buff = data.dup

  buff[1] = noun
  buff[2] = verb

  intcode(buff)
end

# puts intcode([1,0,0,0,99])
# puts intcode([2,3,0,3,99])
# puts intcode([2,4,4,5,99,0])
# puts intcode([1,1,1,4,99,5,6,0,99])

data = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,13,19,23,2,23,9,27,1,6,27,31,2,10,31,35,1,6,35,39,2,9,39,43,1,5,43,47,2,47,13,51,2,51,10,55,1,55,5,59,1,59,9,63,1,63,9,67,2,6,67,71,1,5,71,75,1,75,6,79,1,6,79,83,1,83,9,87,2,87,10,91,2,91,10,95,1,95,5,99,1,99,13,103,2,103,9,107,1,6,107,111,1,111,5,115,1,115,2,119,1,5,119,0,99,2,0,14,0]
puts "Part 1: #{solve(12, 2, data)}"

#Part 2
target = 19690720
found = false
100.times do |n|
  break if found
  100.times do |v|
    ic = solve(n,v, data)
    if(ic == target)
      found = true
      puts "found at: #{n}, #{v}"
      puts "Part 2: #{100 * n + v}"
      break
    end
  end
end
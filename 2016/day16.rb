#!/usr/bin/env ruby
# Day 16 2016
# See http://adventofcode.com/2016/day/16

puts "Advent of Code 2016 day 16"

initial_state = "01110110101001000"
DISK_SIZE = 272

MAX_ITERATIONS = 10000000

def dragon_string(a)    
  b = a.reverse

  result = a + "0"
  b.each_char do |c|
    if(c == "0")
      result += "1"
    else
      result += "0"
    end
  end    
  
  result
end

#assumes an even length string for valid results
def checksum(input)  
  check = ""
  i = 0
  prev_char = ""
  input.each_char do |c|
    if(i % 2 == 1)
      if(prev_char == c)
        check = check + "1"
      else
        check = check + "0"
      end
    end

    prev_char = c
    i += 1
  end

  if(check.length % 2 == 0)
    return checksum(check)
  end

  return check
end

output = initial_state
MAX_ITERATIONS.times do |i|
  if(output.length >= DISK_SIZE)
    output = output[0..DISK_SIZE-1]
    break
  else
    output = dragon_string(output)
  end
end

puts "Output: #{output}"
puts "Checksum: #{checksum(output)}"

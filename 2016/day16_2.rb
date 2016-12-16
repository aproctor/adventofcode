#!/usr/bin/env ruby
# Day 16 2016
# See http://adventofcode.com/2016/day/16

puts "Advent of Code 2016 day 16"

initial_state = "01110110101001000"
DISK_SIZE = 35651584

MAX_ITERATIONS = 10000000

def dragon_string(a)      
  b = a.reverse

  result = [a,"0"]
  b.each_char do |c|
    if(c == "0")
      result << "1"
    else
      result << "0"
    end
  end    
  
  result.join('')
end

#assumes an even length string for valid results
def checksum(input)  
  limit = input.length
  
  MAX_ITERATIONS.times do |x|
    check = []
    chunk = []
    if(limit % 2 != 0)
      return input
    end
    

    j = 0    
    check_flag = false
    limit.times do |i|      
      if(check_flag)
        #replace the input inline, save memory
        chunk << ((input[i-1] == input[i]) ? "1" : "0")
        j += 1        
      end

      check_flag = !check_flag
      if(i % 10000 == 0 && i > 0)  
        check << chunk.join('')
        chunk = []
      end
    end
    if(chunk.length > 0)
      check << chunk.join('')
    end

    limit = j
    input = check.join('')
    puts "C #{limit}"    
  end

  puts "Unable to find checksum"
  return nil
end

# puts checksum("110010110100")

output = initial_state
MAX_ITERATIONS.times do |i|
  puts "#{i} - #{output.length} / #{DISK_SIZE} #{(100*output.length.to_f/DISK_SIZE).round(2)}%" # if i % 10 == 0
  if(output.length >= DISK_SIZE)
    output = output[0..DISK_SIZE-1]
    break
  else
    output = dragon_string(output)
  end
end

puts "Checksum: *#{checksum(output)}*"


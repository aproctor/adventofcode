#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/5

MAX_ITERATIONS = 1000000 #NASA required saftey on while loops

input = nil
File.open('day5.data').each do |line|
  next if(line.nil?)
  input = line
end

# input = "dabAcCaCBAcCcaDA"

def reduce(value, depth)
  if depth > MAX_ITERATIONS
    puts "We dug to deep! panic!"
    return
  end

  # puts "#{depth}: #{value}"
  puts depth if depth % 1000 == 0

  reaction = false
  prev_char = nil
  value.each_char.with_index do |c,i|
    if(c.downcase == prev_char && c != prev_char)
      reaction = true
      #splice out these chars
      buffer = []
      buffer << value[0..i-2] if(i > 2)
      buffer << value[i+1..-1] if(i < value.length - 1)
      value = buffer.join('')

      break
    else
      prev_char = c
    end
  end

  if(reaction)
    reduce(value, depth+1)
  else
    puts "min value found: #{value.length}"
  end

  value
end

reduce(input, 0)

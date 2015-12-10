#!/usr/bin/env ruby
# Day 10
# See http://adventofcode.com/day/10



def look_and_say(line)
  last_char = nil
  num_found = 0

  buffer = []
  line.each_char do |c|
    if(c != last_char && last_char.nil? == false)
      buffer << num_found
      buffer << last_char
    end

    last_char = c
    num_found += 1
  end

  return buffer.join('')
end

num_times = 40
seed = "1113122113"

num_times.times do |i|
  seed = look_and_say(seed)
  puts "#{i}: #{seed.length}"
end
puts "#{seed}"

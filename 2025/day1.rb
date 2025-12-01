#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/1

# Part 1

position = 50
STEPS = 100
p1_count = 0

File.open('day1.data').each do |line|
  next if(line.nil?)
  md = line.match(/([LR])([0-9]+)/)

  if(!md.nil?)
    dir = md[1]
    steps = md[2].to_i

    if(dir == 'L')
      position -= steps
      # if(position < 0)
      #   position = 100 + position
      # end
    elsif(dir == 'R')
      position += steps
    end
    position = position % STEPS

    puts "The dial is rotated #{dir}#{steps} to point at #{position}"
    p1_count += 1 if position == 0
  end
end

puts "Part 1: The dial pointed at 0 a total of #{p1_count} times."


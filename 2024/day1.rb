#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/1

leftList = []
rightList = []
File.open('day1.data').each do |line|
  next if(line.nil?)
  md = line.match(/([0-9]+) *([0-9]+)/)
  if(!md.nil?)
    leftList << md[1].to_i
    rightList << md[2].to_i
  end
end

leftList.sort!
rightList.sort!

distance = 0
leftList.length.times do |i|
  left = leftList[i]
  right = rightList[i]
  distance += (right - left).abs
end

puts "Part 1 Distance: #{distance}"


part2 = 0
leftList.length.times do |i|
  rightList.length.times do |j|
    left = leftList[i]
    right = rightList[j]

    if(left == right)
      part2 += left
    end
  end
end
puts "Part 2 value: #{part2}"
#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/2

def valid_id(number)
  chars = number.to_s.chars
  if chars.length % 2 != 0
    return true
  end

  # split string into two substrings
  mid = chars.length / 2
  first_half = chars[0...mid]
  second_half = chars[mid..-1]

  return first_half != second_half
end


invalid_ids = []
File.open('day2.data').each do |line|
  next if(line.nil?)
  md = line.strip.split(',').each do |range|
    vals = range.split('-').map(&:to_i)
    (vals[0]..vals[1]).each do |i|
      if !valid_id(i)
        invalid_ids << i
        puts "#{i} is an invalid id"
      end
    end
  end
end

puts "Part 1: The sum of all invalid ids is #{invalid_ids.sum}"

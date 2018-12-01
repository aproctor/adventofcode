#!/usr/bin/env ruby
# Day 1 2018
# See http://adventofcode.com/2018/day/1

require "set"

puts "Advent of Code 2018 day 1"


puts "Part 1"
p1_value = 0
instructions = []
File.open('day1.data').each do |line|
    continue if(line.nil?)
    instructions << line.to_i
end


visited = {}
first_repeat = nil

10000.times do |i|
  instructions.each do |n|
    p1_value += n
    if(visited[p1_value].to_i > 0)
      first_repeat = p1_value
      break
    end
    visited[p1_value] = p1_value
  end
  puts "p1: #{p1_value}" if i == 0
  break if first_repeat != nil
end

puts "Part 2"
puts "#{first_repeat}"

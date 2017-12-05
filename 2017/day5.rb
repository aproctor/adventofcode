#!/usr/bin/env ruby
# Day 5 2017
# See http://adventofcode.com/2017/day/5

MAX_ITERATIONS = 100000000

p1_instructions = []
p2_instructions = []

File.open('day5.data').each do |line|
  continue if(line.nil?)  

  p1_instructions << line.to_i
  p2_instructions << line.to_i
end

def part1(p1_instructions)
  cur_offset = 0
  MAX_ITERATIONS.times do |i|
    if(cur_offset < 0 || cur_offset >= p1_instructions.length)
      puts "Part 1 - #{i} instructions"
      break
    end

    jump = p1_instructions[cur_offset]
    p1_instructions[cur_offset] += 1

    cur_offset += jump
  end

  puts "Done"
end

def part2(p2_instructions)
  cur_offset = 0
  MAX_ITERATIONS.times do |i|
    if(cur_offset < 0 || cur_offset >= p2_instructions.length)
      puts "Part 2 - #{i} instructions"
      break
    end

    jump = p2_instructions[cur_offset]
    if jump >= 3
      p2_instructions[cur_offset] -= 1
    else
      p2_instructions[cur_offset] += 1
    end

    cur_offset += jump
  end

  puts "Done"
end

part1(p1_instructions)
part2(p2_instructions)

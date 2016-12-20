#!/usr/bin/env ruby
# Day 15 2016
# See http://adventofcode.com/2016/day/18

puts "Advent of Code 2016 day 18"

TOTAL_ROWS = 40

row = ".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^"
total_safe = 0
SAFE_CHAR = '.'
TRAP_CHAR = '^'

TOTAL_ROWS.times do |r|
  puts row
  total_safe += row.count(".")

  new_row = ""
  row.length.times do |i|
    left = (i == 0) ? SAFE_CHAR : row[i-1]
    right = (i == row.length-1) ? SAFE_CHAR : row[i+1]
    center = row[i]
    
    if(left == TRAP_CHAR && center == TRAP_CHAR && right == SAFE_CHAR)
      new_row << TRAP_CHAR
    elsif(center == TRAP_CHAR && right == TRAP_CHAR && left == SAFE_CHAR)
      new_row << TRAP_CHAR
    elsif(left == TRAP_CHAR && center == SAFE_CHAR && right == SAFE_CHAR)
      new_row << TRAP_CHAR
    elsif(left == SAFE_CHAR && center == SAFE_CHAR && right == TRAP_CHAR)
      new_row << TRAP_CHAR
    else
      new_row << SAFE_CHAR
    end
  end

  row = new_row
end

puts "Total Safe: #{total_safe}"
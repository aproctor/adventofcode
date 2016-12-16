#!/usr/bin/env ruby
# Day 15 2016
# See http://adventofcode.com/2016/day/15

puts "Advent of Code 2016 day 15"

# Disc 1 has 17 positions; at time=0, it is at position 15.
# Disc 2 has 3 positions; at time=0, it is at position 2.
# Disc 3 has 19 positions; at time=0, it is at position 4.
# Disc 4 has 13 positions; at time=0, it is at position 2.
# Disc 5 has 7 positions; at time=0, it is at position 2.
# Disc 6 has 5 positions; at time=0, it is at position 0.
discs = [
  {positions: 17, start: 15},
  {positions: 3, start: 2},
  {positions: 19, start: 4},
  {positions: 13, start: 2},
  {positions: 7, start: 2},
  {positions: 5, start: 0},
  {positions: 11, start: 0}
]

MAX_ITERATIONS = 10000000

MAX_ITERATIONS.times do |i|

  found_time = true
  discs.each_with_index do |d, j|
    
    if((d[:start] + i + j + 1)%d[:positions] != 0)
      found_time = false
      break
    end
  end

  if(found_time == true)
    puts "Found Drop Time #{i}"
    break
  end

end
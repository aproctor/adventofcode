#!/usr/bin/env ruby
# Day 19 2016
# See http://adventofcode.com/2016/day/19
#
# Josephus Problem - https://www.youtube.com/watch?v=uCsD3ZGzMgE

puts "Advent of Code 2016 day 19 - Elephant problem"

def josephus_winner(n)
  #find binary expansion - 2^a + l  
  a = Math.log2(n).floor
  l = n - 2**a

  #winner = 2*l + 1
  return 2*l + 1
end

p1_num = 3017957
puts "Part 1 - with #{p1_num} elves #{josephus_winner(p1_num)} wins"
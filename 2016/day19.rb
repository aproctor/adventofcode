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

def brute_forcephus_winner(n)
  #Present stealing has been moved to across from current elf
  #we could do the math and come up with a new proof... or we could just run through the numbers

  #build a linked list of all numbers
  first_elf = nil
  last_elf = nil
  n.times do |i|
    elf = Elf.new(i+1)
    if(first_elf.nil?)
      first_elf = elf
    end
    if(!last_elf.nil?)
      last_elf.next = elf
    end

    last_elf = elf
  end
  #point last elf at first elf to complete the circle
  last_elf.next = first_elf

  elf = first_elf
  num_left = n
  while(num_left > 1)
    
    #shift to find elf to kill
    kill_shift = (num_left / 2).floor
    prev_elf = next_elf = elf
    kill_shift.times do |k|
      prev_elf = next_elf
      next_elf = next_elf.next
    end
    #kill off "next_elf" by pointing past him and excluding him from the chain
    prev_elf.next = next_elf.next

    num_left -= 1
    elf = elf.next

    puts "N: #{num_left}" if num_left % 100 == 0
  end

  return elf.value
end

class Elf
  attr_accessor :value, :next

  def initialize(value)
      @value = value
  end
end

num_elves = 10 #3017957
puts "Part 1 - with #{num_elves} elves #{josephus_winner(num_elves)} wins"
puts "Part 2 - with #{num_elves} elves #{brute_forcephus_winner(num_elves)} wins"


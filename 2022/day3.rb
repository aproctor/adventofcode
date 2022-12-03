#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/3

def letter_value(letter)
  return (letter.ord - 'A'.ord + 27) if letter.ord < 'a'.ord

  (letter.ord - 'a'.ord + 1)
end

def bag_sum(contents)
  #puts "Bag sum for <#{contents}>"

  existing = {}

  mid = contents.length / 2

  contents.each_char.with_index do |c,i|
    if i < mid
      existing[c] = 1
    elsif existing.key? c
      # puts "duplicate found: #{c} with val #{letter_value(c)}"
      return letter_value(c)
    end
  end

  0
end

def badge_value(group_bags)
  # puts "Group bags check #{group_bags}"
  existing = {}
  group_bags[0].each_char do |c|
    existing[c] = 1
  end

  common = {}
  group_bags[1].each_char do |c|
    common[c] = 1 if existing.key? c
  end

  group_bags[2].each_char do |c|
    if common.key? c
      # puts "#{c} exists in all 3 group_bags"
      return letter_value(c)
    end
  end

  0
end

p1_total = 0
p2_total = 0
bags = []
File.open('day3.data').each do |line|
  next if(line.nil?)
  line.strip!

  p1_total += bag_sum(line) if line.length > 1

  bags << line
  if(bags.length == 3)
    p2_total += badge_value(bags)
    bags = []
  end
end

puts "Part 1: #{p1_total}"
puts "Part 2: #{p2_total}"


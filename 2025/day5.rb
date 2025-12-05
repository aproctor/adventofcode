#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/5

state = :fresh_ranges

def is_in_ranges?(num, ranges)
  ranges.each do |r|
    if(num >= r[0] && num <= r[1])
      return true
    end
  end
  return false
end

p1_count = 0
ranges = []
File.open('day5.data').each do |line|
  next if(line.nil?)
  line.strip!
  if(state == :fresh_ranges)
    if(line == "")
      state = :available_ingredients
      next
    end

    # ranges are like "1-4"
    a = line.split("-").map(&:to_i)
    ranges << a
    #puts "a: #{a.inspect}"
  elsif(state == :available_ingredients)
    if(line.length == 0)
      state = :done
      next
    end

    ingredient = line.to_i
    fresh = false
    if(is_in_ranges?(ingredient, ranges))
      fresh = true
      p1_count += 1
    end
    # puts "ingredient: #{ingredient}, fresh: #{fresh}"
  end
end

puts "Part 1: #{p1_count}"
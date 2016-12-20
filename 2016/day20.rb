#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/20

puts "Advent of Code 2016 day 20"

ranges = []
alt_min = 0
File.open('day20.data').each do |line|
  next if(line.nil?)
  
  md = line.match(/(\d+)-(\d+)/)
  new_range = [md[1].to_i,md[2].to_i]

  found_existing_range = false
  deprecated_ranges = []
  ranges.each_with_index do |old_range, i|
    if(old_range[0] <= new_range[0] && old_range[1] >= new_range[1])      
      #encapsulated, discard new range      
      found_existing_range = true
    elsif(old_range[0] < new_range[0] && old_range[1] + 1 >= new_range[0])
      # old range includes lower bound, but implicitly not upper bound
      # eg:
      #  o[1-7] + n[3-10]
      #  o[1-7] + n[7-10]
      #  o[1-6] + n[7-10]
      new_range[0] = old_range[0]
      deprecated_ranges << i
    elsif(old_range[0] <= new_range[1] + 1 && old_range[1] > new_range[1])
      # old range includes upper bound, but implicitly not lower bound
      # o[4-9] + n[2-6]
      # becomes [2-9]      
      new_range[1] = old_range[1]
      deprecated_ranges << i
    end

    break if found_existing_range
  end

  #Remove any old ranges deprecated by this new range. Backwards by index
  deprecated_ranges.reverse.each do |d|
    ranges.delete_at(d)
  end

  if(found_existing_range == false)
    ranges << new_range
  end
end

min_max = 4294967295
max_min = -1
ranges.each do |rg|
  max_min = rg[0] if(rg[0] > max_min)
  min_max = rg[1] if(rg[1] < min_max)
  #puts "r: #{rg}"
end
puts "max_min #{max_min}"
puts "min_max #{min_max}"


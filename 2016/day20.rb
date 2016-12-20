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
  ranges.each do |old_range|
    if(old_range[0] <= new_range[0] && old_range[1] >= new_range[1])      
      #encapsulated, discard new range      
      found_existing_range = true
    elsif(old_range[0] < new_range[0] && old_range[1] + 1 >= new_range[0])
      # [1-7] + [3-10]
      # becomes [1-10]      
      old_range[1] = new_range[1]
      found_existing_range = true      
    elsif(old_range[0] <= new_range[1] + 1 && old_range[1] > new_range[1])
      # [4-9] + [2-6]
      # becomes [2-9]      
      old_range[0] = new_range[0]
      found_existing_range = true
    end

    break if found_existing_range
  end

  if(found_existing_range == false)
    puts "new: #{new_range}"
    ranges << new_range
  end
end

min_max = 4294967295
max_min = -1
ranges.each do |rg|
  max_min = rg[0] if(rg[0] > max_min)
  min_max = rg[1] if(rg[1] < min_max)
  puts "r: #{rg}"
end
puts "max_min #{max_min}"
puts "min_max #{min_max}"


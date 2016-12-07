#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/7

puts "Advent of Code 2016 day 7"


#Part 1 - search for ABBA

def contains_abba?(line)
  within_hnet_seq = false

  #the minimum index an ABBA can be found.  Moves with hnet
  min_index = 3
  i = 0

  found_good_abba = false
  found_bad_abba = false

  line.each_char do |c|

    if(!within_hnet_seq && c == "[")
      within_hnet_seq = true 
      min_index = i + 4    
    elsif(within_hnet_seq && c == "]")
      within_hnet_seq = false 
      min_index = i + 4
    end

    if(i >= min_index)
      #check for ABBA
      if(line[i-3] == line[i] && line[i-2] == line[i-1] && line[i] != line[i-1])
        if(within_hnet_seq)
          found_bad_abba = true
          break
        else
          found_good_abba = true
        end
      end
    end

    i += 1
  end 

  return found_good_abba && !found_bad_abba
end

p1_abba_count = 0
File.open('day7.data').each do |line|
  continue if(line.nil?)

  if(contains_abba?(line))
    p1_abba_count += 1
  end
end


puts "part 1 - abba's found #{p1_abba_count}"
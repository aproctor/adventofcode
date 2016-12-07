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


def contains_aba_bab?(line)
  within_hnet_seq = false

  #the minimum index an ABBA can be found.  Moves with hnet
  min_index = 2
  i = 0

  outside_matches = []
  inside_matches = []

  line.each_char do |c|

    if(!within_hnet_seq && c == "[")
      within_hnet_seq = true 
      min_index = i + 3    
    elsif(within_hnet_seq && c == "]")
      within_hnet_seq = false 
      min_index = i + 3
    end

    if(i >= min_index)
      #check for ABA
      if(line[i-2] == line[i] && line[i] != line[i-1])
        if(within_hnet_seq)
          #invert match for comparison
          inside_matches.push("#{line[i-1]}#{line[i]}#{line[i-1]}")
        else
          outside_matches.push(line[i-2..i])
        end
      end
    end

    i += 1
  end 

  inside_matches.each do |bab|
    outside_matches.each do |aba|    
      return true if(aba == bab)
    end
  end
  return false
end

p1_abba_count = 0
p2_aba_bab_count = 0
File.open('day7.data').each do |line|
  continue if(line.nil?)

  if(contains_abba?(line))
    p1_abba_count += 1
  end
  if(contains_aba_bab?(line))
    p2_aba_bab_count += 1
  end
end


puts "part 1 - abba's found #{p1_abba_count}"
puts "part 2 - aba bab's found #{p2_aba_bab_count}"
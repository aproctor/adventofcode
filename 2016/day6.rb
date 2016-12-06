#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/6

puts "Advent of Code 2016 day 6"


#Part 1 - unjam the signal

char_hashes = []

File.open('day6.data').each do |line|
  continue if(line.nil?)

  i = 0
  line.each_char do |c|
    if(char_hashes[i].nil?)
      #initialize new character counter    
      char_hashes[i] = {}
    end


    if(!char_hashes[i].key?(c))
      char_hashes[i][c] = 1
    else
      char_hashes[i][c] = char_hashes[i][c] + 1
    end

    i += 1
  end
end

#sort by count (desc), then alphabetical (asc), then take the first 5 keys and make a checksum string
top_chars = []
char_hashes.each_with_index do |h, i|
  top_chars[i] = h.sort_by { |letter, count| -count}.to_h.keys.first
end  


puts "part1 #{top_chars.join('')}"

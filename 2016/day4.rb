#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/4

puts "Advent of Code 2016 day 4"


#Part 1 - sum of sector ids
p1_sum = 0
File.open('day4.data').each do |line|
  continue if(line.nil?)

  #split data into side numbers
  matched_chars = {}

  md = /([a-z\-]+)-(\d+)\[(.*)\]/.match(line) 
  sector = md[2].to_i
  checksum = md[3]

  md[1].each_char do |c|
    next if c == '-'

    if(matched_chars.key?(c))
      matched_chars[c] = matched_chars[c] + 1
    else
      matched_chars[c] = 1
    end
  end

  #sort by count (desc), then alphabetical (asc), then take the first 5 keys and make a checksum string
  top_chars = matched_chars.sort_by { |letter, count| [-count,letter]}.to_h.keys[0..4].join('')
  if(top_chars == checksum)
    p1_sum += sector
  end  


end

puts "part1 sum of sector codes #{p1_sum}"



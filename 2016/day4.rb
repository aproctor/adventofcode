#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/4

puts "Advent of Code 2016 day 4"


#Part 1 - sum of sector ids
p1_sum = 0

#Part 2 - ordenance of characters
a_ord = 'a'.ord
z_ord = 'z'.ord
num_chars = z_ord - a_ord + 1

File.open('day4.data').each do |line|
  continue if(line.nil?)

  #split data into side numbers
  matched_chars = {}

  md = /([a-z\-]+)-(\d+)\[(.*)\]/.match(line) 
  sector = md[2].to_i
  checksum = md[3]

  shifted_vals = []
  md[1].each_char do |c|
    if c == '-'
      shifted_vals.push(' ')
    else
      #count character for checksum
      if(matched_chars.key?(c))
        matched_chars[c] = matched_chars[c] + 1
      else
        matched_chars[c] = 1
      end

      #translate character assuming it's valid
      shifted_vals.push((((c.ord + sector - a_ord) % num_chars) + a_ord).chr)
    end
  end

  #sort by count (desc), then alphabetical (asc), then take the first 5 keys and make a checksum string
  top_chars = matched_chars.sort_by { |letter, count| [-count,letter]}.to_h.keys[0..4].join('')
  if(top_chars == checksum)
    p1_sum += sector
    
    puts "#{shifted_vals.join('')} - #{sector}"
  end  


end

puts "part1 sum of sector codes #{p1_sum}"

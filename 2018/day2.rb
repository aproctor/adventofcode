#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/2

puts "Advent of Code 2018 day 2"


puts "Part 1"
doubles = 0
tripples = 0
File.open('day2.data').each do |line|
    continue if(line.nil?)
    letters = {}
    line.each_char do |c|
      # nil.to_i is 0
      letters[c] = letters[c].to_i + 1
    end

    found_dbl = false
    found_tripple = false    
    letters.each do |k,v|      
      found_dbl = true if(v == 2)
      found_tripple = true if(v == 3)
    end
    doubles += 1 if found_dbl
    tripples +=1 if found_tripple
    # puts "#{found_dbl}, #{found_tripple}, #{letters.inspect}"
end

puts "doubles: #{doubles}, tripples: #{tripples}, checksum: #{doubles*tripples}"


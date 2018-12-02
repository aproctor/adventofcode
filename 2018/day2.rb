#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/2

puts "Advent of Code 2018 day 2"


puts "Part 1"
doubles = 0
tripples = 0
box_ids = []
File.open('day2.data').each do |line|
    next if(line.nil?)
    box_ids << line[0..-2] #trim new line character
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


puts "Part 2 - closest ids"

found_closest = false
box_ids.each_with_index do |id1, i|
  box_ids.each_with_index do |id2, j|
    next if i == j

    differences = 0
    common_chars = []
    #we'll assume they're the same length for lazy reasons
    id1.each_char.with_index do |c, index|
      if c != id2[index]
      differences += 1 
      else
        common_chars << c
      end
      break if differences > 1
    end

    if(differences == 1)
      puts "Closest found"
      puts "id 1 #{id1}"
      puts "id 2 #{id2}"
      puts "common chars: #{common_chars.join('')}"
      found_closest = true
      break
    end
  end
  break if found_closest
end
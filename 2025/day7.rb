#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/7

state = :startup

beams = {}
split_count = 0
File.open('day7.data').each do |line|
  next if(line.nil?)
  line.strip!

  
  new_beams = {}
  if(!line.empty?)
    length = line.length
    line.each_char.with_index do |c, i |  
      if(c == '^' && beams[i])        
        new_beams[i-1] = true if i > 0 && !beams[i-1]
        new_beams[i+1] = true if i < length - 1 && !beams[i+1]
        split_count += 1
      elsif(c == 'S' || beams[i])
        new_beams[i] = true
      end
      if(beams[i] && c != '^')
        print "|"
      else
        print c
      end
    end
    puts ""
  end
  beams = new_beams
end

puts "Part 1: #{split_count}"

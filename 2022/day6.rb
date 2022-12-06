#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/6

def start_of_packet(line)
  puts line

  sequence = []
  line.each_char.with_index do |c, i|
    sequence.shift if i >= 4
    sequence << c
    
    unique_sequence = true
    if sequence.length == 4
      #validate uniqueness
      sequence.tally.each do |k,v|
        unique_sequence = false if v > 1
      end

      if unique_sequence
        puts "Unique sequence found from #{i-4} to #{i}: #{sequence.join('')}"
        return i+1
      end
    end

  end

  nil
end

# puts start_of_packet("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
# puts start_of_packet("bvwbjplbgvbhsrlpgdmjqwftvncz")
# puts start_of_packet("nppdvjthqldpwncqszvftbrmjlhg")
# puts start_of_packet("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
# puts start_of_packet("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")

File.open('day6.data').each do |line|
  next if(line.nil?)
  puts start_of_packet(line)
end
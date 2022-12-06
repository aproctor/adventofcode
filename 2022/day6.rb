#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/6

def start_of_packet(line, seq_len)
  # puts line

  sequence = []
  line.each_char.with_index do |c, i|
    sequence.shift if i >= seq_len
    sequence << c
    
    unique_sequence = true
    if sequence.length == seq_len
      #validate uniqueness
      sequence.tally.each do |k,v|
        unique_sequence = false if v > 1
      end

      if unique_sequence
        # puts "Unique sequence found from #{i-seq_len} to #{i}: #{sequence.join('')}"
        return i+1
      end
    end

  end

  nil
end

# puts start_of_packet("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14)
# puts start_of_packet("bvwbjplbgvbhsrlpgdmjqwftvncz", 14)
# puts start_of_packet("nppdvjthqldpwncqszvftbrmjlhg", 14)
# puts start_of_packet("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 14)
# puts start_of_packet("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 14)

File.open('day6.data').each do |line|
  next if(line.nil?)
  puts "Part 1:"
  puts start_of_packet(line, 4)

  puts "\nPart 2:"
  puts start_of_packet(line, 14)
end
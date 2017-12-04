#!/usr/bin/env ruby
# Day 4 2017
# See http://adventofcode.com/2017/day/4

def p1_valid_passphrase?(row)
  words = {}
  row.gsub(/\s+/m, ' ').strip.split(" ").each do |val|
    return false if(words.key?(val))
    words[val] = 1
  end

  true
end

# puts p1_valid_passphrase?("aa bb cc dd ee")
# puts p1_valid_passphrase?("aa bb cc dd aa")
# puts p1_valid_passphrase?("aa bb cc dd aaa")

p1_valid_phrases = 0
File.open('day4.data').each do |line|
  continue if(line.nil?)

  p1_valid_phrases += 1 if(p1_valid_passphrase?(line))
end
puts "Part 1 - #{p1_valid_phrases}"

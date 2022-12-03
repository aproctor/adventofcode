#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/3

def letter_value(letter)
  return (letter.ord - 'A'.ord + 27) if letter.ord < 'a'.ord

  (letter.ord - 'a'.ord + 1)
end

def bag_sum(contents)
  #puts "Bag sum for <#{contents}>"

  existing = {}

  mid = contents.length / 2

  contents.each_char.with_index do |c,i|
    if i < mid
      existing[c] = 1
    elsif existing.key? c
      # puts "duplicate found: #{c} with val #{letter_value(c)}"
      return letter_value(c)
    end
  end

  0
end

total = 0
File.open('day3.data').each do |line|
  next if(line.nil?)

  total += bag_sum(line.strip) if line.length > 1
end

puts "Total: #{total}"
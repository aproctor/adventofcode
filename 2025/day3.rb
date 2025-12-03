#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/3

p1_total = 0
File.open('day3.data').each do |line|
  next if(line.nil?)

  battery = line.strip.each_char.map(&:to_i)
  #puts battery.inspect

  # Find the largest number in the array comprised of two digits without re-ordering
  largest_first_digit = -1
  largest_indecies = []
  battery.each_with_index do |digit, index|
    break if(index+1 >= battery.length)

    #candidate = (digit * 10) + battery[next_index]
    if(digit > largest_first_digit)
      largest_first_digit = digit
      largest_indecies = [index]
    elsif(digit == largest_first_digit)
      largest_indecies << index
    end
  end

  largest_value = -1
  second_digit_offset = largest_indecies.min + 1
  (second_digit_offset..battery.length-1).each do |i|
    candidate = (largest_first_digit * 10) + battery[i]
    if(candidate > largest_value)
      largest_value = candidate
    end
  end

  p1_total += largest_value
end

puts "Part 1 Total: #{p1_total}"
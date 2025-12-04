#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/3


##############
# Part 1
############

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

puts "Part 1 Total: #{p1_total}\n"


##############
# Part 2
############

target_digits = 12
p2_total = 0
File.open('day3.data').each do |line|
  next if(line.nil?)

  battery = line.strip.each_char.map(&:to_i)
  # puts battery.inspect


  stack = []
  battery.each_with_index do |digit, index|
    #puts "Processing digit #{digit} at index #{index}"
    if(index == 0)
      stack << digit
      next
    end

    remaining_digits = battery.length - (index + 1)
    valid_replacement_offset = [target_digits - remaining_digits - 1, 0].max
    found_replacement = false
    (valid_replacement_offset..stack.length-1).each do |i|
      if(digit > stack[i])
        stack = stack[0...i] + [digit]
        found_replacement = true
        break
      end
    end
    if(!found_replacement && stack.length < target_digits)
      stack << digit
    end

    # puts "Stack: #{stack.inspect}, remaining: #{remaining_digits}, valid offset: #{valid_replacement_offset}"

  end


  p2_total += stack.join.to_i
end

puts "Part 2 Total: #{p2_total}\n"
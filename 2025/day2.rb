#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/2

def get_factors(number, known_factors)
  return known_factors[number] if known_factors.key?(number)
  factors = []
  (1..Math.sqrt(number)).each do |i|
    if number % i == 0
      factors << i
      if i != number / i
        factors << number / i
      end
    end
  end
  known_factors[number] = factors.sort

  return factors.sort
end

def p1_valid_id(number)
  chars = number.to_s.chars
  if chars.length % 2 != 0
    return true
  end

  # split string into two substrings
  mid = chars.length / 2
  first_half = chars[0...mid]
  second_half = chars[mid..-1]

  return first_half != second_half
end

def p2_valid_id(number, known_factors)
  chars = number.to_s.chars
  len = chars.length
  factors = get_factors(len, known_factors)
  if factors.length < 2
    return true
  end

  factors.each do |f|
    next if f == len

    segment = chars[0...f].join('')
    target = ""
    (len / f).times do |i|
      target += segment
    end

    if target.to_i == number
      return false
    end
  end

  return true
end

factors_cache = {}
p1_invalid_ids = []
p2_invalid_ids = []
File.open('day2.data').each do |line|
  next if(line.nil?)
  md = line.strip.split(',').each do |range|
    vals = range.split('-').map(&:to_i)
    (vals[0]..vals[1]).each do |i|
      if !p1_valid_id(i)
        p1_invalid_ids << i
        #puts "#{i} is an invalid id for part 1"
      end

      if !p2_valid_id(i, factors_cache)
        #puts "#{i} is an invalid id for part 2"
        p2_invalid_ids << i
      end
    end
  end
end

puts "Part 1: The sum of all invalid ids is #{p1_invalid_ids.sum}"
puts "Part 2: The sum of all invalid ids is #{p2_invalid_ids.sum}"
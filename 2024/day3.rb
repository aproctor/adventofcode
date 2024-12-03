#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/3

def part1_multiply_all_matches(multiples, verbose = false)
  total = 0
  buffer = []

  multiples.each do |m|
    total += m[0].to_i * m[1].to_i
    buffer << "#{m[0]}*#{m[1]}"
  end

  puts buffer.join(" + ") + " = #{total}" if verbose

  total
end

multiples = []
File.open('day3.data').each do |line|
  next if(line.nil?)
  md = line.scan(/mul\(([0-9]{1,3}),([0-9]{1,3})\)/)
  if(!md.nil?)
    multiples.concat md
  end
end

puts "Part 1"
p1_total = part1_multiply_all_matches(multiples, true)
puts p1_total

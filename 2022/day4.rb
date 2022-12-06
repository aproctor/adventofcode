#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/4


class Elf
  attr_accessor :min, :max

  def initialize(min, max)
    @min = min
    @max = max
  end

  def overlaps?(other)
    !(@max < other.min || @min > other.max)
  end

  def contains?(other)
    (@min <= other.min && @max >= other.max)
  end
end

p1_total = 0
p2_total = 0
File.open('day4.data').each do |line|
  next if(line.nil?)
  md = line.match(/([0-9]+)-([0-9]+),([0-9]+)-([0-9]+)/)
  if(!md.nil?)
    # puts md
    elf1 = Elf.new(md[1].to_i, md[2].to_i)
    elf2 = Elf.new(md[3].to_i, md[4].to_i)
    if elf1.contains?(elf2) || elf2.contains?(elf1)
      # puts "contains!"
      p1_total += 1
    end

    if elf1.overlaps?(elf2)
      # puts "Overlap"
      p2_total += 1
    end
  end
end

puts "Part 1: #{p1_total}"
puts "Part 2: #{p2_total}"

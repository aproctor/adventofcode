#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/12

def bold_string(input)
  "\u001b[1m#{input}\u001b[0m"
end
def color_code(value)
  "\u001b[38;5;#{value}m"
end
def color_test
  16.times do |i|
    16.times do |j|
      value = i*16 + j
      print "#{color_code(value)} #{value}"
    end
  end
end
#color_test

class Terrain
  def initialize(path)
    @map_data = []

    File.open(path).each do |line|
      next if(line.nil?)
      @map_data << line.strip.chars
    end
  end

  def print_map
    @map_data.each do |row|
      row.each do |c|
        print "#{color_for_char(c)}#{c}"
      end
      print "\n"
    end

    # 100.times do |i|
    #   r = (i+1) / 24.0
    #   col = color_for_depth(r)
    #   print "#{col}#{i} "
    # end
  end

  private

  def color_for_char(c)
    return color_code(5) if c == "S"
    return color_code(1) if c == "E"

    offset = c.ord - "a".ord

    color_for_depth(offset / 24.0)
  end

  def color_for_depth(ratio)
    pallette = [29, 22, 35, 71, 77, 41, 47, 78, 84, 114, 120, 156]
    c = pallette[(ratio * (pallette.length-1)).round]

    color_code(c)
  end
end

#t = Terrain.new('day12_test.data')
t = Terrain.new('day12.data')
t.print_map

# reset terminal (kinda janky but just for my own environment sanity)
print color_code(249)


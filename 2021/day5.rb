#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/5


class Line
  attr_accessor :x1, :y1, :x2, :y2

  # Input is in the format of "0,9 -> 5,9\n"
  def initialize(x1, y1, x2, y2)
  	@x1 = x1
  	@y1 = y1
  	@x2 = x2
  	@y2 = y2
  end

  def all_points
    points = []

    mode = :uknown
    extents = []
    if @x1 == @x2
      mode = :vertical
      extents = [@y1, @y2]
    elsif @y1 == @y2
      mode = :horizontal
      extents = [@x1, @x2]
    end

    if mode == :vertical || mode == :horizontal
      extents.sort!
      (extents[0] .. extents[1]).each do |i|
        if mode == :vertical
          points << [@x1, i]
        elsif mode == :horizontal
          points << [i, @y1]
        end
      end
    end

    points
  end
end

class Board
  attr_accessor :lines

  def initialize
    @map = {}
    @lines = []

    @min_x = nil
    @min_y = nil
    @max_x = nil
    @max_y = nil
  end

  def add_line(line)
    @lines << line

    line.all_points.each do |p|
      k = p.join(',')
      if @map.key?(k)
        @map[k] += 1
      else
        @map[k] = 1
      end

      # puts "point #{p.join(',')}"

      # check extents
      @min_x = p[0] if @min_x.nil? || p[0] < @min_x
      @min_y = p[1] if @min_y.nil? || p[1] < @min_y
      @max_x = p[0] if @max_x.nil? || p[0] > @max_x
      @max_y = p[1] if @max_y.nil? || p[1] > @max_y
    end
  end

  def draw
    puts "Drawing board from (#{@min_x}, #{@min_y}) -> (#{@max_x}, #{@max_y})"

    (@min_y .. @max_y).each do |y|
      vals = []
      (@min_x .. @max_x).each do |x|
        k = "#{x},#{y}"
        if @map.key?(k)
          vals << @map[k]
        else
          vals << 0
        end        
      end

      puts vals.join('')
    end
  end

  def overlapping_nodes
    overlap_count = 0
    @map.each do |k,v|
      overlap_count += 1 if v > 1
    end

    overlap_count
  end
end

board = Board.new
File.open('day5.data').each do |line|
  next if(line.nil?)
  
  md = line.match(/(\-?[0-9]+),(\-?[0-9]+) -> (\-?[0-9]+),(\-?[0-9]+)/)
  if(!md.nil?)
    # puts "Line #{line.strip}"
  	board.add_line(Line.new(md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i))
  end
end

puts "Part 1"
board.draw
puts "Overlap Count: #{board.overlapping_nodes}"
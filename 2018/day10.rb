#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/10

MIN_X = -5
MAX_X = 20
MIN_Y = -5
MAX_Y = 20
STEPS = 5

width = MAX_X - MIN_X
height = MAX_Y - MIN_Y

class Point  
  attr_accessor :x, :y, :v_x, :v_y

  def initialize(x, y, v_x, v_y)
    @origin_x = @x = x
    @origin_y = @y = y
    @v_x = v_x
    @v_y = v_y
  end

  def step
    @x += @v_x
    @y += @v_y
  end

  def reset
    @x = @origin_x
    @y = @origin_y
  end
end

points = []
File.open('day10.data').each do |line|
  next if(line.nil?)
  md = line.match(/position=< *(\-?[0-9]+), *(\-?[0-9]+)> velocity=< *(\-?[0-9]+), *(\-?[0-9]+)>/)
  if(!md.nil?)
    points << Point.new(md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i)    
  end
end

STEPS.times do |i|
  puts "Step #{i}:"
  #clear buffer
  buffer = []
  height.times do |r|
    buffer[r] = []
    width.times do |c|
      buffer[r][c] = "."
    end
  end

  #mark points
  points.each do |p|
    row = p.y - MIN_Y
    col = p.x - MIN_X
    if(row >= 0 && col >= 0 && row < height && col < width)
      buffer[row][col] = "#"
    end
    p.step
  end

  #draw buffer
  height.times do |r|
    puts buffer[r].join("")
  end

end





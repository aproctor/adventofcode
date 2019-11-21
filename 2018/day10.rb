#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/10

require 'chunky_png'

MIN_X = -500
MAX_X = 500
MIN_Y = -500
MAX_Y = 500
SCALE_FACTOR = 1
STEPS = 30
JUMPS_PER_STEP = 1
START_STEPS = 10020

width = ((MAX_X - MIN_X) / SCALE_FACTOR).round
height = ((MAX_Y - MIN_Y) / SCALE_FACTOR).round

class Point  
  attr_accessor :x, :y, :v_x, :v_y

  def initialize(x, y, v_x, v_y)
    @origin_x = @x = x
    @origin_y = @y = y
    @v_x = v_x
    @v_y = v_y
  end

  def step(scale = 1)
    @x += @v_x * scale
    @y += @v_y * scale
  end

  def reset
    @x = @origin_x
    @y = @origin_y
  end
end

def transform(point, width, height)
  row = (point.y - MIN_Y) / SCALE_FACTOR
  col = (point.x - MIN_X) / SCALE_FACTOR

  if(row < 0 || col < 0 || row >= height || col >= width)
    return [nil, nil]
  end
  return [row,col]
end

points = []
File.open('day10.data').each do |line|
  next if(line.nil?)
  md = line.match(/position=< *(\-?[0-9]+), *(\-?[0-9]+)> velocity=< *(\-?[0-9]+), *(\-?[0-9]+)>/)
  if(!md.nil?)
    points << Point.new(md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i)    
  end
end

points.each do |p|
  p.step(START_STEPS)
end

STEPS.times do |i|
  puts "Step #{i}:"

  # Creating an image from scratch, save as an interlaced PNG
  png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::BLACK)
  
  #mark points
  white = ChunkyPNG::Color('white')
  points.each do |p|
    pos = transform(p, width, height)
    row = pos[0]
    col = pos[1]
    if(!row.nil? && !col.nil?)
      png[col,row] = white
    end
    p.step(JUMPS_PER_STEP)
  end
  png.save("day10out/step#{i}.png", :interlace => true)
end





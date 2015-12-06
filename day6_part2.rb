#!ruby
# Day 6
# See http://adventofcode.com/day/6

require 'chunky_png'


GRID_SIZE = 1000
PIXEL_SIZE = 1

def draw_grid(grid, max_brightness)
  puts "Drawing out the image"
  png = ChunkyPNG::Image.new(GRID_SIZE*PIXEL_SIZE, GRID_SIZE*PIXEL_SIZE, ChunkyPNG::Color::TRANSPARENT)
  #Draw out graphic
  GRID_SIZE.times do |x|
    GRID_SIZE.times do |y|
      val = ((grid[x][y].to_f / max_brightness)*255).to_i
      color = ChunkyPNG::Color.rgb(val,val,val)
      png.rect(x*PIXEL_SIZE, y*PIXEL_SIZE, (x+1)*PIXEL_SIZE, (y+1)*PIXEL_SIZE, color,  color)      
    end
  end
  png.save('day6.png', :interlace => true)
end


grid = Array.new(GRID_SIZE) { Array.new(GRID_SIZE) }

#Part 1
File.open('day6.data').each do |line|
  continue if(line.nil?)

  if(line.match(/(turn on|turn off|toggle) [0-9]+,[0-9]+ through [0-9]+,[0-9]+/).nil?)
    puts "skipping invalid line <#{line}>"
    continue
  end

  # I should use a more formal grammar for this, but whatever Regex time
  # Commands look like this:   
  # "turn off 743,684 through 789,958"
  # "toggle 692,845 through 866,994"
  # "turn on 943,30 through 990,907"

  parts = line.split("through")
  start_point = parts[0].match(/[0-9,]+/).to_s.split(",").map(&:to_i)
  end_point = parts[1].match(/[0-9,]+/).to_s.split(",").map(&:to_i)

  if(line.start_with?("toggle"))
    toggle = true
  else
    toggle = false
    if(line.start_with?("turn on"))
      value = 1
    else
      value = -1
    end
  end

  (start_point[0]..end_point[0]).each do |x|
    (start_point[1]..end_point[1]).each do |y|
      if(toggle)
        grid[x][y] = grid[x][y].to_i + 2
      else
        grid[x][y] = [grid[x][y].to_i + value,0].max
      end
    end
  end
end

brightness = 0
max_num = 0
GRID_SIZE.times do |x|
  GRID_SIZE.times do |y|
    brightness += grid[x][y].to_i
    max_num = [max_num, grid[x][y].to_i].max
  end
end

#puts "number lit: #{num_lit}"
puts "brightness: #{brightness}"
puts "max brightness: #{max_num}"

draw_grid(grid, max_num)

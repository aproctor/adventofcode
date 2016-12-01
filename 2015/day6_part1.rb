#!ruby
# Day 6
# See http://adventofcode.com/day/6

require 'chunky_png'


GRID_SIZE = 1000
PIXEL_SIZE = 1

def draw_grid(grid)
  puts "Drawing out the image"
  png = ChunkyPNG::Image.new(GRID_SIZE*PIXEL_SIZE, GRID_SIZE*PIXEL_SIZE, ChunkyPNG::Color::TRANSPARENT)
  #Draw out graphic
  GRID_SIZE.times do |x|
    GRID_SIZE.times do |y|
      color = ChunkyPNG::Color::BLACK
      if(grid[x][y] == 1)
        color = ChunkyPNG::Color::WHITE
      end

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
      value = 0
    end
  end

  (start_point[0]..end_point[0]).each do |x|
    (start_point[1]..end_point[1]).each do |y|
      if(toggle)
        grid[x][y] = (grid[x][y] == 1) ? 0 : 1
      else
        grid[x][y] = value
      end
    end
  end
end

num_lit = 0
GRID_SIZE.times do |x|
  GRID_SIZE.times do |y|
    num_lit += grid[x][y].to_i
  end
end

puts "number lit: #{num_lit}"

draw_grid(grid)

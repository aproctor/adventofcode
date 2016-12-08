#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/8

puts "Advent of Code 2016 day 8"


def create_grid(w,h)
  grid = []
  h.times do |r|
    grid[r] = []
    w.times do |c|
      grid[r][c] = '.'
    end
  end

  return grid
end


def add_rect(grid, w, h)
  rows = grid.length
  cols = grid[0].length

  h.times do |r|
    w.times do |c|
      grid[r][c] = '#'
    end
  end
end

def rotate(grid, type, offset, amount)
  rows = grid.length
  cols = grid[0].length

  if(type == :row)
    a = cols - amount
    r = grid[offset]
    grid[offset] = r.drop(a).concat(r.take(a))
  elsif(type == :column)
    values = []
    a = rows - amount

    #copy current
    rows.times do |r|
      values[r] = grid[r][offset]
    end

    #shift values by offset
    values = values.drop(a).concat(values.take(a))

    #copy new values into grid
    rows.times do |r|
      grid[r][offset] = values[r]
    end
  end

end

def print_grid(grid)
  grid.length.times do |r|    
    puts "#{grid[r].join('')}"
  end
end


#Part 1 - sum of sector ids
P1_COLS = 50
P1_ROWS = 6

grid = create_grid(P1_COLS, P1_ROWS)

File.open('day8.data').each do |line|
  continue if(line.nil?)

  rect_instruction = /rect (\d+)x(\d+)/.match(line) 
  if(!rect_instruction.nil?)    
    add_rect(grid, rect_instruction[1].to_i,rect_instruction[2].to_i)
  else
    rotate_instruction = /rotate (row|column) (x|y)=(\d+) by (\d+)/.match(line) 
    if(!rotate_instruction.nil?)
      rotate(grid, rotate_instruction[1].to_sym,rotate_instruction[3].to_i,rotate_instruction[4].to_i)
    end
  end
 
end

num_lit = 0
P1_ROWS.times do |r|
  P1_COLS.times do |c|
    num_lit += 1 if(grid[r][c] == "#")
  end
end

puts "\npart 1 - number of lit pixels #{num_lit}"
puts "part 2 - code:"
print_grid(grid)
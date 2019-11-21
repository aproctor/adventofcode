#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/11

def power_level(x, y, serial)
  # Find the fuel cell's rack ID, which is its X coordinate plus 10.
  rack_id = x + 10

  # Begin with a power level of the rack ID times the Y coordinate.
  power = rack_id * y

  # Increase the power level by the value of the grid serial number (your puzzle input).
  power += serial

  # Set the power level to itself multiplied by the rack ID.
  power *= rack_id

  # Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
  power = (power / 100) % 10

  # Subtract 5 from the power level.
  power -= 5

  #explicit return not needed, but i don't like implicit returns
  return power
end

def debug_grid(serial, offset_x, offset_y, width, height)
  height.times do |i|
    row = []
    width.times do |j|
      x = j + offset_x
      y = i + offset_y
      row << power_level(x,y, serial)
    end
    puts "#{row.join("  ")}"
  end
end

def area_power(x,y, serial, area_w, area_h)
  total_power = 0
  area_h.times do |i|
    area_w.times do |j|
      total_power += power_level(x+j, y+i, serial)
    end
  end

  return total_power
end

def max_power(serial, width, height, area_w, area_h)
  max = -99999
  top_power = nil

  width.times do |r|
    height.times do |c|
      x = c+1
      y = r+1
      power = area_power(x,y, serial, area_w, area_h)      
      if power > max
        max = power
        top_power = [max, x, y, area_w, area_h]
      end
    end
  end

  return top_power
end

def p1_power(serial)
  top_power = max_power(serial, 300, 300, 3, 3)
  #debug_grid(serial, top_power[0]-1, top_power[1]-1, 5, 5)
  puts "Max power #{top_power[0]} at: (#{top_power[1]},#{top_power[2]}) #{top_power[3]}x#{top_power[4]}"
end

def p2_power(serial)
  cur_max = [-99999]

  (1..300).each do |w|
    (1..300).each do |h|
      mp = max_power(serial, 300, 300, w,h)

      if mp[0] > cur_max[0]
        cur_max = mp
      end
      # puts "#{w}x#{h} checked"
    end
  end

  puts "Max power #{top_power[0]} at: (#{top_power[1]},#{top_power[2]}) #{top_power[3]}x#{top_power[4]}"
end

# puts "Part 1:"
# p1_power(18)
# p1_power(42)
# p1_power(7672)

puts "Part 2:"
p2_power(18)
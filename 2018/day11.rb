#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/11

class AreaGrid

  def initialize(serial,w,h)
    @serial = serial
    @grid_width = w
    @grid_height = h

    @power_hash = {}
  end

  def power_level(x, y)
    # Find the fuel cell's rack ID, which is its X coordinate plus 10.
    rack_id = x + 10

    # Begin with a power level of the rack ID times the Y coordinate.
    power = rack_id * y

    # Increase the power level by the value of the grid serial number (your puzzle input).
    power += @serial

    # Set the power level to itself multiplied by the rack ID.
    power *= rack_id

    # Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
    power = (power / 100) % 10

    # Subtract 5 from the power level.
    power -= 5

    #explicit return not needed, but i don't like implicit returns    
    return power
  end

  def debug_grid(offset_x, offset_y, width, height)
    height.times do |i|
      row = []
      width.times do |j|
        x = j + offset_x
        y = i + offset_y
        row << power_level(x,y)
      end
      puts "#{row.join("  ")}"
    end
  end

  def area_power(x,y, size)   
    #Area of 1x1 is a base case, just return power level 
    return power_level(x,y) if size == 1

    key = "#{x},#{y},#{size}"

    # puts "whats: #{key}?"

    #found a value in the cache? return it
    return @power_hash[key] if @power_hash.key?(key)

    total_power = 0

    #simple hack, we know we're going from small to large, so size of x-1 should be cached, let's grab that
    #this should only recurse with a depth of 1
    total_power += area_power(x,y, size-1)

    #now let's measure ethe power of the extra row and column
    edge_row = y + size - 1
    edge_col = x + size - 1

    # puts "Edge Row: #{edge_row}, Edge Col: #{edge_col}"

    #measure row
    (x..edge_col).each do |rx|
      total_power += power_level(rx, edge_row)
      # puts "row add (#{rx}, #{edge_row}) #{power_level(rx, edge_row)}"
    end    

    #measure col (exclusive, since the corner is already counted)
    (y...edge_row).each do |ry|
      total_power += power_level(edge_col, ry)
      # puts "col add (#{edge_col}, #{ry}) #{power_level(edge_col, ry)}"
    end

    @power_hash[key] = total_power

    # puts "ap[#{key}] = #{total_power}"

    return total_power
  end

  def max_power(size)
    area_w = area_h = size
    max = -99999
    top_power = nil

    mr = @grid_height - area_h + 1
    mc = @grid_width - area_w + 1
    
    (1..mr).each do |r|
      (1..mc).each do |c|
        x = c+1
        y = r+1
        power = area_power(x,y, size)      
        if power > max
          max = power
          top_power = [max, x, y, size]
        end
      end
    end

    return top_power
  end

  def p1_power
    top_power = max_power(3)
    debug_grid(top_power[0]-1, top_power[1]-1, 5, 5)
    puts "Max power #{top_power.shift} at: (#{top_power.join(',')})"
  end

  def p2_power
    top_power = [-99999]

    (1..@grid_width).each do |w|
      h = w
      mp = max_power(w)

      if mp[0] > top_power[0]
        top_power = mp
      end
      puts "#{w}x#{h} checked"
    end

    puts "Max power #{top_power.shift} at: (#{top_power.join(',')})"
  end

end

# puts "Part 1:"
# AreaGrid.new(18,300,300).p1_power
# AreaGrid.new(42,300,300).p1_power
# AreaGrid.new(7672,300,300).p1_power

puts "Part 2:"
AreaGrid.new(18,300,300).p2_power
# AreaGrid.new(7672,300,300).p2_power
#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/8


class ElfTree
  attr_accessor :x, :y, :height, :visible, :focused

  def initialize(x, y, height)
    @height = height
    @x = x
    @y = y
    @visible = false
    @focused = false
  end

  def coord
    "#{@x},#{@y}"
  end
end

class Forest  
  
  def initialize
    @cur_y = 0
    @max_x = 0
    @tree_map = {}  #using a map rather than a 2-dimensional array in anticipation of p2
  end

  def add_tree_line(trees)
    
    trees.each_char.with_index do |c, x|
      new_tree = ElfTree.new(x, @cur_y, c.to_i)
      @tree_map[new_tree.coord] = new_tree

      @max_x = x if x > @max_x
    end

    @cur_y += 1
  end

  def p1_explore
    #check horizontal    
    @cur_y.times do |y|      
      # Check from left to right
      current_height = -1
      (0..@max_x).each do |x|
        tree_check = check_tree_visibility(x, y, current_height)
        if(tree_check >= 0)
          current_height = tree_check
        end
      end

      #check from right to left
      current_height = -1
      (0..@max_x).each do |offset|
        x = @max_x - offset
        tree_check = check_tree_visibility(x, y, current_height)
        if(tree_check >= 0)
          current_height = tree_check
        end
      end      
      
    end
    
    #check vertical, skipping outer columns since they were just checked
    (1..@max_x-1).each do |x|      
      
      #check from top
      current_height = -1
      @cur_y.times do |y|
        tree_check = check_tree_visibility(x, y, current_height)
        if(tree_check >= 0)
          current_height = tree_check
        end
      end

      #check from bottom
      current_height = -1
      @cur_y.times do |offset|
        y = @cur_y-1-offset
        tree_check = check_tree_visibility(x, y, current_height)
        if(tree_check >= 0)
          current_height = tree_check
        end
      end

    end

    count = 0
    @tree_map.values.each do |t|
      count += 1 if t.visible
    end
    
    count
  end

  def p2_explore
    max_y = @cur_y - 1 # simplify references so it's consistent with max_x

    highest_score = 0

    @tree_map.values.each do |tree|
      reset_visibility()
      tree.focused = true

      scenic_score = 1

      right_view = 0
      # look to the right
      (tree.x+1..@max_x).each do |x|
        coord = "#{x},#{tree.y}"
        t2 = @tree_map[coord]
        t2.visible = true
        right_view += 1
        break if t2.height >= tree.height       
      end


      left_view = 0
      #look to the left
      (0..tree.x-1).each do |offset|
        x = tree.x-1 - offset
        coord = "#{x},#{tree.y}"
        t2 = @tree_map[coord]
        t2.visible = true
        left_view += 1
        break if t2.height >= tree.height       
      end

      #look down
      down_view = 0
      (tree.y+1..max_y).each do |y|
        coord = "#{tree.x},#{y}"
        t2 = @tree_map[coord]
        t2.visible = true
        down_view += 1
        break if t2.height >= tree.height  
      end

      #look up
      up_view = 0
      (0..tree.y-1).each do |offset|
        y = tree.y-1 - offset

        coord = "#{tree.x},#{y}"
        t2 = @tree_map[coord]
        t2.visible = true
        up_view += 1
        break if t2.height >= tree.height  
      end

      scenic_score = left_view * right_view * down_view * up_view

      highest_score = scenic_score if scenic_score > highest_score

      # if tree.x == 2 && tree.y == 3
      #   debug_print
      #   puts "Scenic Score: #{scenic_score}"
      # end
    end

    highest_score
  end

  def debug_print
    @cur_y.times do |y|
      buffer = []
      (0..@max_x).each do |x|
        tree = @tree_map["#{x},#{y}"]
        color = (tree.visible) ? 32 : 30
        color = 31 if tree.focused
        buffer << "\e[#{color}m"
        buffer << tree.height
        buffer << "\e[0m"
      end

      puts buffer.join()
    end
  end

private
  def reset_visibility
    @tree_map.values.each do |t|
      t.visible = false
      t.focused = false
    end
  end

  def check_tree_visibility(x, y, current_height)
    coord = "#{x},#{y}"
    if @tree_map.key?(coord)
      tree = @tree_map[coord]
      if tree.height > current_height
        tree.visible = true
        return tree.height
      end
    end

    -1
  end

end

forest = Forest.new
File.open('day8.data').each do |line|
  next if(line.nil?)
  md = line.match(/([0-9]+)/)
  if(!md.nil?)
    forest.add_tree_line(md[1])
  end
end

puts "Part 1"
puts forest.p1_explore
#forest.debug_print

puts "Part 2"
puts forest.p2_explore

# [30,32,92,30].each do |i|
#   puts "\e[#{i}m#{i}\e[0m"
# end
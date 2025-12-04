#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/4

def coord(x, y)
  "#{x},#{y}"
end

def count_neighbors(x1, y1, rolls_map)
  count = 0
  (-1..1).each do |dy|
    (-1..1).each do |dx|
      next if(dx == 0 && dy == 0)

      pos = coord(x1 + dx, y1 + dy)
      if rolls_map.key?(pos)
        count += 1
      end
    end
  end

  count
end

rolls_map = {}
y = 0
x = 0
max_x = 0
File.open('day4.data').each do |line|
  next if(line.nil?)

  x = 0
  line.strip!.each_char.with_index do |char, index|
    if char == '@'
      rolls_map[coord(x, y)] = char
    end

    x += 1
  end
  max_x = [max_x, x].max

  #puts "#{y}: "  + line

  y += 1
end

max_y = y

p1_total = 0
max_y.times do |cy|
  #print "#{cy}: "
  max_x.times do |cx|
    pos = coord(cx, cy)
    if rolls_map.key?(pos)
      count = count_neighbors(cx, cy, rolls_map)
      if count < 4
        p1_total += 1
        print "x"
      else
        print "@"
      end
    else
      print "."
    end
  end
  puts ""
end

puts "Part 1: #{p1_total}"

# Part 2
p2_total = 0
max_iterations = rolls_map.size
max_iterations.times do |iteration|
  puts "Iteration #{iteration}:"
  iteraction_total = 0
  max_y.times do |cy|
    #print "#{cy}: "
    max_x.times do |cx|
      pos = coord(cx, cy)
      if rolls_map.key?(pos)
        count = count_neighbors(cx, cy, rolls_map)
        if count < 4
          iteraction_total += 1
          print "x"
          rolls_map.delete(pos)
        else
          print "@"
        end
      else
        print "."
      end
    end
    puts ""
  end

  puts "removed total: #{iteraction_total}"
  p2_total += iteraction_total

  if iteraction_total == 0
    break
  end
end

puts "Part 2: #{p2_total}"
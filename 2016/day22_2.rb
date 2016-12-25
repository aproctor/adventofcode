#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/22

puts "Advent of Code 2016 day 22"


class Node  
  attr_accessor :x, :y, :size, :used

  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def available
    return @size - @used
  end

  def used_pct
    return @used.to_f / @size
  end

  def key
    return "#{@x},#{@y}"
  end

  def valid_pair?(other_node)
    return false if(@used == 0)    
    return false if(other_node.key == self.key)        
    return (@used <= other_node.available)
  end
end

nodes = {}
max_x = 0
max_y = 0
File.open('day22.data').each do |line|
  next if(line.nil? || line[0] != '/')

  #Filesystem              Size  Used  Avail
  #/dev/grid/node-x0-y0     85T   69T    16T
  nd = /node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T/.match(line)
  node = Node.new({
    x: nd[1].to_i,
    y: nd[2].to_i,
    size: nd[3].to_i,
    used: nd[4].to_i
  })
  max_x = node.x if(node.x > max_x)
  max_y = node.y if(node.y > max_y)

  nodes["#{node.key}"] = node
end

valid_pairs = []
nodes.values.each do |n1|
  nodes.values.each do |n2|    
    valid_pairs << [n1,n2] if(n1.valid_pair?(n2))
  end
end

puts "part 1 - valid pairs #{valid_pairs.length}"

#31 x 29
(max_y + 1).times do |r|
  (max_x + 1).times do |c|
    
  end
end

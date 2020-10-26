#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/6

class Node
  attr_accessor :val
  attr_accessor :parent
  attr_accessor :children

  @@node_map = {}
  @@orbit_counts = {}

  def initialize(val)
    @val = val
    @children = []
  end

  def self.find_or_create(val) 
  	if !@@node_map.key?(val)
  		@@node_map[val] = Node.new(val)
  	end
  	@@node_map[val]
  end

  def self.print_all
  	@@node_map.each do |k,v|
  		parent = v.parent.nil? ? "nil" : v.parent.val
  		puts "#{k} - orbits: #{v.orbit_count} parent: #{parent}, chilren: (#{v.children.map(&:val).join(', ')})"
  	end
  end

  def self.total_orbits
  	total = 0
  	@@node_map.each do |k,v|
  		total += v.orbit_count
  	end

  	total
  end

  def orbit(other)
  	#puts "#{@val} orbits #{other.val}"

  	@parent = other
  	other.children << self
  end

  def orbit_count(visited={})
  	#puts @val
  	return 0 if @parent.nil? || visited.key?(@val)
  	return @@orbit_counts[@val] if @@orbit_counts.key?(@val)
  	
  	visited[@val] = true

  	@@orbit_counts[@val] = @parent.orbit_count(visited) + 1
  end

  def sub_orbit_counts
  	# Calculate all orbit counts by traversing children
  	total = orbit_count
  	children.each do |c|
  		total += c.sub_orbit_counts
  	end

  	total
  end

  def path_to_com
  	return [@val] if(parent == nil)
  	p = parent.path_to_com
  	p << @val

  	return p
  end
end

root = nil

File.open('day6.data').each do |line|
  next if(line.nil?)

  md = line.match(/^([A-Z0-9]+)\)([A-Z0-9]+)$/)
  if(!md.nil?)
  	n1 = Node.find_or_create(md[1])
  	n2 = Node.find_or_create(md[2])  	
  	n2.orbit(n1)

  	root = n1 if root.nil?
  else
  	puts "INVALID <#{line}>"
  end
end

#####
#  Part 1 - orbit counts
###

#Node.print_all
# puts root.inspect
# puts Node.find_or_create("D").orbit_count
# puts Node.find_or_create("L").orbit_count
# puts Node.find_or_create("COM").orbit_count
# puts root.sub_orbit_counts
puts "Part 1: #{Node.total_orbits}"

puts "Part 2"
you_path = Node.find_or_create("YOU").path_to_com
santa_path = Node.find_or_create("SAN").path_to_com
puts you_path.inspect
puts santa_path.inspect
prev = nil
same_nodes = 0
[you_path.length, santa_path.length].min.times do |i|
	if you_path[i] != santa_path[i]
		break
	end	
	prev = you_path[i]
	same_nodes += 1
end
puts "\tSame Nodes #{same_nodes}"
puts "\tyou_path length = #{you_path.length}"
puts "\tsanta_path length = #{santa_path.length}"
jumps = (you_path.length - 1 - same_nodes) + (santa_path.length - 1 - same_nodes)
puts "\tjumps between #{jumps}"


puts "done"
#!/usr/bin/env ruby
# Day 7 2017
# See http://adventofcode.com/2017/day/7

class TreeNode
	attr_accessor :child_names
	attr_accessor :name
	attr_accessor :weight
	attr_reader :children
	attr_accessor :parent

	def initialize(name, weight, child_names)		
		@name = name
		@weight = weight
		@children = []
		@child_names = (child_names.nil?) ? [] : child_names.split(", ")		
	end

	def add_child(node)
		@children << node
		node.parent = self
	end
end

node_map = {}
File.open('day7.data').each do |line|
  continue if(line.nil?)
  #puts "#{line}"
  md = line.match(/([a-z]+) \((\d+)\)( -> )?([a-z, ]+)?/) 
  if(md)
  	node_map[md[1]] = TreeNode.new(md[1],md[2].to_i,md[4])
  else
  	puts "Bad line #{line}"
  end
end

#Connect nodes to their parents
node_map.each do |name,node|
	node.child_names.each do |child_name|
		node.add_child(node_map[child_name])
	end
end

node_map.each do |name, node|
	if(node.parent.nil?)
		puts "Part 1 - Root node is #{name}"
	end
end

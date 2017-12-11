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
	
	def total_weight(verbose = false)
		return @memoized_weight if(!@memoized_weight.nil? && !verbose)		
		puts "++#{self.name} (#{weight})" if verbose
		child_weight = 0
		@children.each do |child|
			child_weight += child.total_weight(false)		
			puts "#{child.name} (#{child.weight}) -> (#{child.total_weight})" if verbose
		end

		@memoized_weight = @weight + child_weight
	end

	def balanced?
		if(@children.length > 0)
			first_w = @children[0].total_weight
			@children.each_with_index do |c,i|
				return false if(i > 0 && c.total_weight != first_w)
			end
		end

		true
	end

	def rebalance
		return if balanced?  #inefficient, but safe to check

		#major assumption is that only one node in the entire tree is wrong
		#but one wrong weight makes the rest of the nodes below unbalanced as well
		#so if a child is unbalanced as well, the problem is not on this node

		#find child with outlier weight, adjust it's weight to compensate for it's children
		weight_map = {}
		mode = nil
		@children.each_with_index do |c, i|

			if !c.balanced?
				#problem isn't on this node, go to the child and balance it
				puts "passing the buck from #{self.name} to #{c.name}"
				c.rebalance
				return
			end

			w = c.total_weight
			#puts "#{i}: #{w}"
			if(weight_map[w].nil?)				
				weight_map[c.total_weight] = i
			else
				#we've seen this weight before, and know that only one weight is wrong
				mode = w
			end
		end

		puts "Children not balanced: "
		@children.each do |c2|
			puts "#{c2.name}: #{c2.total_weight}"
		end

		weight_map.each do |w,i|
			if(w != mode && !mode.nil?)
				puts "Found outlier at #{i}.  #{@children[i].name} (#{w}) needs to be #{mode}"

				puts "#{@children[i].total_weight(true)}"

				delta = mode - w

				@children[i].weight += delta
				
				puts "Part 2 - Delta is #{delta}"
				break
			end
		end

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
	if(!node.balanced?)
		puts "#{name} is not balanced"
		node.rebalance
		break
	end
end

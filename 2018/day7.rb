#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/7

ALL_NODES = {}
MAX_ITERATIONS = 10000000

class Node
  attr_accessor :ref, :blocking, :blocked_by

  def initialize(ref)
    @ref = ref
    @blocking = {}
    @blocked_by = {}
  end

  def block(node)
  	@blocking[node.ref] = node
  	node.blocked_by[self.ref] = self
  end

  def free?
  	return (@blocked_by.count == 0)
  end

  def destroy
  	@blocking.each do |r,n|
  		n.blocked_by.delete(@ref)
  	end
  	ALL_NODES.delete(@ref)
  end

  def to_s
  	return "#{@ref} -> #{blocking.keys}"
  end

end

def node_for_ref(ref)
	return ALL_NODES[ref] if ALL_NODES.key?(ref)
		
	n = Node.new(ref)
	ALL_NODES[ref] = n

	return n	
end

File.open('day7.data').each do |line|
  next if(line.nil?)
  
  #Step C must be finished before step A can begin.
  md = line.match(/Step ([A-Za-z]+) must be finished before step ([A-Za-z]+) can begin./)
  if(!md.nil?)
  	n1 = node_for_ref(md[1])
  	n2 = node_for_ref(md[2])
  	n1.block(n2)
  end
end
ALL_NODES = ALL_NODES.sort.to_h

# ALL_NODES.each do |k,n|
# 	puts n.to_s
# end

steps = []
MAX_ITERATIONS.times do |i|
	break if (ALL_NODES.count == 0)
	ALL_NODES.each do |r,n|
		if n.free?
			steps << r
			n.destroy
			break
		end
	end
end
puts "Steps:\n#{steps.join('')}"






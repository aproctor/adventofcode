#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/7

ALL_NODES = {}
MAX_ITERATIONS = 20
BUSY_DURATION_BASE = 1
NUM_WORKERS = 2
COMPLETED_NODES = []

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

class Worker
	attr_accessor :remaining_steps, :node

	def intialize
		@remaining_steps = 0
		@node = nil
	end

	def busy?
		return @node != nil
	end

	def process(node)
		@remaining_steps = node.ref.ord - "A".ord  + BUSY_DURATION_BASE		

		@node = node
		#puts "unlocking: #{@node}"
		#puts "Remaining steps: #{@remaining_steps}"
		@node.blocked_by["worker"] = self
	end

	def status
		return @node.nil? ? "." : @node.ref
	end

	def tick
		if self.busy?			
			@remaining_steps -= 1			
			if @remaining_steps <= 0
				#puts "Boom: #{@node.ref}"
				COMPLETED_NODES << @node.ref
				@node.destroy
				@node = nil
			end			
		elsif !ALL_NODES.empty?
			#find new node
			ALL_NODES.each do |r,n|
				if n.free?
					#puts "Node free: #{n}"
					self.process(n)
					break
				end
			end

			#puts "Unable to find free node" if !busy?
		end
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

workers = []
NUM_WORKERS.times do 
	workers << Worker.new
end

# ALL_NODES.each do |k,n|
# 	puts n.to_s
# end

ticks = 0
MAX_ITERATIONS.times do |i|
	break if (ALL_NODES.count == 0)
	
	debug = []
	debug << i
	workers.each do |w|
		w.tick
		debug << w.status
	end
	debug << COMPLETED_NODES.join("")
	puts "#{debug.join("\t")}"
	

	ticks += 1
end
puts "======"
puts "Ticks: #{ticks}"






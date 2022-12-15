#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/14

class Element
  attr_accessor :key, :next

  @@counts = {}

  def initialize(key)  	
    @key = key
    @next = nil

    if !@@counts.key?(key)
    	@@counts[key] = 1
    else
    	@@counts[key] = @@counts[key] + 1
    end
  end

  def sequence
  	return @key if @next.nil?

  	"#{@key}#{@next.sequence}"
  end

  def pair
  	return nil if @next.nil?

  	"#{@key}#{@next.key}"
  end

  def insert(c)
  	new_node = Element.new(c)
  	new_node.next = @next
  	@next = new_node
  end

  def self.p1_solution
  	# puts @@counts.inspect

  	min_val = nil
  	max_val = nil
  	@@counts.each do |k, v|
  		if max_val.nil?
  			min_val = v
  			max_val = v
  		else
  			min_val = v if v < min_val
  			max_val = v if v > max_val
  		end
  	end

  	max_val - min_val
  end

  def self.debug_print
  	puts @@counts.inspect
  end
end

MAX_STEPS = 40

p1_map = {}

template = nil

File.open('day14.data').each do |line|
  next if(line.nil?)

  if template.nil?
  	template = line.strip
  else
  	md = line.match(/([A-Z]+) -> ([A-Z]+)/)
	  if(!md.nil?)
	    p1_map[md[1]] = md[2]
	  end
  end
end

# puts p1_map.inspect

# puts "Template: \t#{template}"


# Build Element list off of template string
root = nil
cur_node = nil
template.each_char.with_index do |c, i|
	new_node = Element.new(c)
	if cur_node == nil		
		root = new_node
		cur_node = new_node
	else
		cur_node.next = new_node
		cur_node = new_node
	end
end


# Part 1

(1..MAX_STEPS).each do |s|
	puts "Step #{s}/#{MAX_STEPS}"

	cur_node = root
	while !cur_node.next.nil? do
		pair = cur_node.pair

		if p1_map.key?(pair)
			cur_node.insert(p1_map[pair])
			cur_node = cur_node.next.next #we just inserted a node jump ahead 2 to continue sequencing
		else
			cur_node = cur_node.next	
		end		
	end

	Element::debug_print
end

puts "Part 1:"
puts Element::p1_solution

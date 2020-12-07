#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/6

# light red bags contain 1 bright white bag, 2 muted yellow bags.
# dark orange bags contain 3 bright white bags, 4 muted yellow bags.
# bright white bags contain 1 shiny gold bag.
# muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
# shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
# dark olive bags contain 3 faded blue bags, 4 dotted black bags.
# vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
# faded blue bags contain no other bags.
# dotted black bags contain no other bags.

class BagConnection
	attr_accessor :number, :parent_ref, :child_ref

	def initialize(n, p, c)
		@number = n
		@parent_ref = p
		@child_ref = c

		@@all_connections ||= []
		@@all_connections << self
	end

	def to_s
		"\t#{@number} #{parent_ref}->#{child_ref}"
	end

	def self.children_of(parent_ref)
		children = []
		@@all_connections.each do |bc|
			if(bc.parent_ref == parent_ref)
				children << bc
			end
		end

		children
	end

	def self.parents_of(child_ref)
		parents = []
		@@all_connections.each do |bc|
			if(bc.child_ref == child_ref)
				parents << bc
			end
		end

		parents
	end
end

class Bag
	attr_accessor :reference

	def initialize(ref, contain_string)
		@reference = ref
		@children = []
		@parent_refs = []

		contain_string.split(',').each do |contents|
			md = contents.match(/([0-9])+([a-z ]+) bag/)
			if(!md.nil?)
				@children << BagConnection.new(md[1].to_i, ref, md[2].strip)
			end
		end
	end

	def children
		BagConnection::children_of(@reference)
	end

	def parents
		BagConnection::parents_of(@reference)
	end

	def print
		puts "#{@reference}"
		children.each do |c|
			puts c
		end
	end
end

bags = {}
File.open('day6.data').each do |line|
  next if(line.nil?)
  md = line.match(/([a-z ]+) bags contain ([^.]+)\./)
  if(!md.nil?)
		bags[md[1]] = Bag.new(md[1], md[2])    		
  else
  	puts "NO MATCH: #{line.strip}"
  end
end

# Part 1 - How many unique color suitcases can contain shiny gold
bags.each do |k, v|
	#v.print
end

def find_parents(bag, map, all_bags)
	bag.parents.each do |bag_con|
		p_ref = bag_con.parent_ref

		if(map.key?(p_ref))
			#puts "Not following parent #{p_ref}, already evaluted"
		else
			pb = all_bags[p_ref]
			map[p_ref] = pb

			find_parents(pb, map, all_bags)
		end
	end
end

shiny_gold = bags["shiny gold"]
parent_map = {}
find_parents(shiny_gold, parent_map, bags)
puts "Part 1: #{parent_map.keys.length}"


# Part 2 - How many bags are in my shiny gold bag
def nested_bag_count(bag_ref)
	total_children = 1

	BagConnection::children_of(bag_ref).each do |bcon|
		total_children += bcon.number * nested_bag_count(bcon.child_ref)
	end

	total_children
end

child_bag_count = nested_bag_count(shiny_gold.reference) - 1
puts "Part 2: #{child_bag_count}"


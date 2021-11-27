#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/16



class Sue
  attr_accessor :id, :attrs

  def initialize(input)
    @attrs = {}

    md = input.strip.match(/Sue ([0-9]+): (.+)/)
    raise "Invalid Sue" if(md.nil?)

    @id = md[1]
    md[2].split(', ').each do |pair|
    	vals = pair.split(': ')
    	@attrs[vals[0].to_sym] = vals[1].to_i
    end

    # puts self.inspect
  end

  def matches(other)
  	other.attrs.each do |k,v|
  		if(@attrs.key?(k))
  			return false if @attrs[k] != v
  		end
  	end

  	true
  end

  def part2(template)
  	template.attrs.each do |k,v|
  		if(@attrs.key?(k))
  			if k == :trees || k == :cats
  				return false if @attrs[k] <= v
  			elsif k == :pomeranians || k == :goldfish
  				return false if @attrs[k] >= v
  			else
  				return false if @attrs[k] != v	
  			end  			
  		end
  	end

  	true
  end
end

target_sue = Sue.new("Sue 0: children: 3, cats: 7, samoyeds: 2, pomeranians: 3, akitas: 0, vizslas: 0, goldfish: 5, trees: 3, cars: 2, perfumes: 1")

File.open('day16.data').each do |line|
  next if(line.nil?)
  sue = Sue.new(line)
  if sue.matches(target_sue)
  	puts "Part 1: Sue #{sue.id} matches target"
  end

  if sue.part2(target_sue)
  	puts "Part 2: Sue #{sue.id} matches target"
  end

end


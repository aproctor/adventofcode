#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/10

class Line
	attr_accessor :a1, :a2

	def initialize(a1, a2)
		@a1 = a1
		@a2 = a2
		@angle = nil
	end

	def dx
		(@a2.x - @a1.x)
	end

	def dy
		(@a2.y - @a1.y)
	end

	def angle
		if(@angle.nil?)
			@angle = Math.atan2(self.dy, self.dx)
		end

		@angle
	end

	# Manhattan distance for faster computation
	def manhattan_dist
		(self.dx.abs + self.dy.abs)
	end

	def sort_val
		(angle * 1000) + manhattan_dist
	end

	def to_s
		"#{@a1.key} -> #{@a2.key}, #{self.sort_val} #{@angle}"
	end
end

class Asteroid
  attr_accessor :x, :y, :neighbours, :destroyed

  @@all_asteroids = {}
  def self.all_asteroids
  	@@all_asteroids
  end

  def initialize(x, y)
    @x = x
    @y = y
    @neighbours = {}
    @destroyed = false

    @@all_asteroids[self.key] = self
  end  

  def key
  	"#{@x},#{@y}"
  end

  def connected_to?(other)
  	return false if self.key == other.key
  	return true if @neighbours.key?(other.key)

  	# determine line: y = mx + c
  	
  	#puts "\nLine between #{self.key} -> #{other.key}:"
  	dx = (other.x - @x)
  	if(dx != 0)
  		dy = (other.y - @y)
	  	m = dy.to_f / dx
	  	c = @y - m*@x	  	
  		#puts "y = #{m}x + #{c}"
  	else
  		#puts "x = #{@x}"
	  end
  	

  	#check if any other asteroids block these two asteroids
  	# - check first that they're on the same line
  	# - then check it's not between them by using manhattan distance
	  manhattan_dist = (@x - other.x).abs + (@y - other.y).abs

  	@@all_asteroids.each do |k, a|
  		next if(k == self.key || k == other.key)

  		#check if a is on the line
  		if(dx == 0)
  			online = (a.x == @x)
  		else
  			#puts "#{a.y.to_f} == #{(m.to_f*x.to_f + c.to_f)}"
  			lineY = (m*a.x + c)
  			online = (a.y - lineY).abs < 0.0001  					
  		end

  		if(online)
  			#check if it's between the other asteroids
  			# - a point will be between two other points if it's distance to both points is less than their distance to each other
  			# - we want something cheap so we'll just do manhattan distance
  			d1 = (@x - a.x).abs + (@y - a.y)
  			d2 = (other.x - a.x).abs + (other.y - a.y).abs

  			if(d1 < manhattan_dist && d2 < manhattan_dist)
  				#puts "#{k} blocks #{self.key} <> #{other.key}"
	  			return false 
	  		end
  		end
  	end

  	true
  end

  def to_s
  	"#{@x},#{@y} -> #{@neighbours.count}"
  end

  def self.build_connections
  	@@all_asteroids.each do |k1, a1|
  		@@all_asteroids.each do |k2, a2|
  			if(a1.connected_to?(a2))
  				# Connect 2 asteroids
  				a1.neighbours[k2] = a2
  				a2.neighbours[k1] = a1
  			end
  		end
  	end
  end

  def self.print_asteroids(mode = :verbose)
  	if(mode == :compact)
  		maxX = 0
  		maxY = 0
  		@@all_asteroids.each do |k,v|
  			maxX = v.x if v.x > maxX
  			maxY = v.y if v.y > maxY
  		end

  		(maxY + 1).times do |y|
  			line = ""
  			(maxX + 1).times do |x|
  				k = "#{x},#{y}"
  				if @@all_asteroids.key?(k)
  					line << "#{@@all_asteroids[k].neighbours.count}"
  				else
  					line << "."
  				end
  			end
  			puts line
  		end
  	else
	  	@@all_asteroids.each do |k,v|
	  		puts v
	  	end
	  end
  end

  def self.find(k)
  	@@all_asteroids[k]
  end

  def self.find_base
  	maxNeighbours = 0
  	baseKey = nil

  	@@all_asteroids.each do |k,v|
  		if(v.neighbours.count > maxNeighbours)
  			baseKey = k
  			maxNeighbours = v.neighbours.count
  		end
  	end

  	@@all_asteroids[baseKey]
  end

  def self.destroy_asteroids(base, limit)
  	lines = []
  	@@all_asteroids.each do |k, a|
  		next if(k == base.key)

  		lines << Line.new(base, a)
  	end

  	# lines.sort { |l1, l2| l1.sort_val <=> l2.sort_val }

  	lines.each do |l|
  		puts l
  	end
  	
  end
end


row = 0;
File.open('day10.data').each do |line|
  next if(line.nil?)
  col = 0
  line.each_char do |c|  	
    Asteroid.new(col, row) if(c == '#')
    col += 1
  end
  
  row += 1
end

puts "Part 1"
Asteroid::build_connections
#Asteroid::print_asteroids(:verbose)
#Asteroid::print_asteroids(:compact)
base = Asteroid::find_base
puts "#{base.key} is the base asteroid with #{base.neighbours.count} neighbours"

puts "\nPart 2"
Asteroid::destroy_asteroids(base,200)
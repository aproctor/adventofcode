#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/3

class Point
	include Comparable

	attr_accessor :x, :y

	def initialize(x, y)
		@x = x
		@y = y
	end

	def zero?
		x == 0 && y == 0
	end

	def to_s
		"#{@x},#{@y}"
	end

	def dist
		(@x + @y)
	end

	#compare points based on their manhattan distance to origin
	def <=>(other)
		self.dist <=> other.dist
	end
end

class Line
	attr_accessor :p1, :p2

	def initialize(x1, y1, x2, y2)
		if(x1 < x2)
	  		@p1 = Point.new(x1, y1)
	  		@p2 = Point.new(x2, y2)
	  	else
	  		@p1 = Point.new(x2, y2)
			@p2 = Point.new(x1, y1)
	  	end
	end

	#These lines are only vertical or horizontal
	def vertical?
		return @p1.x == @p2.x
	end

	def contains_point?(p)
		#is p on this line?
	    #x is already sorted
		if(p.x >= @p1.x && p.x <= @p2.x)
			ys = [@p1.y, @p2.y].sort
			if(p.y >= ys[0] && p.y <= ys[1])
				return true
			end
		end

		return false
	end

	def min_intersection(other)
		# find where 2 segments overlap, but only return lowest co-ordinate value if they overlap in multiple places

		if(self.vertical? && other.vertical?)
			#TODO vertical overlap results
			#for now assume none
		elsif(!self.vertical? && !other.vertical?)
			#TODO horizontal overlap results
			#for now assume, none
		else
			#1 vert, 1 horizontal, project intersection simply by taking u
			if(self.vertical?)
				p = Point.new(@p1.x, other.p1.y)
			else
				p = Point.new(other.p1.x, @p1.y)
			end

			#special case, we're ignoring origin overlaps as per spec
			return nil if(p.zero?)



			#is p on this line?
			if(self.contains_point?(p) && other.contains_point?(p))
				puts "Point: #{p} is on Line: #{self} and Line: #{other}"
				return p
			end
		end		
		return nil
	end

	def to_s
		"#{@p1} -> #{@p2}"
	end
end	

class Wire
  attr_accessor :x, :y, :lines

  def initialize(path)
    @x = 0
    @y = 0
    @lines = []

    path.split(",").each do |c|
    	self.move(c)
    end
  end

  def move(cmd)
  	dir = cmd[0]
  	len = cmd[1..-1].to_i

  	x1 = @x
  	y1 = @y
  	
  	case dir
  	when "R"
  		@x += len
  	when "L"
  		@x -= len
  	when "U"
  		@y += len
  	else
  		@y -= len
  	end
  	@lines << Line.new(x1, y1, @x, @y)
  end

  def intersections(other)
  	res = []

  	@lines.each do |l1|
  		other.lines.each do |l2|
  			cross = l1.min_intersection(l2)
  			res << cross if !cross.nil?
  		end
  	end
  	
  	return res
  end

end

w1 = Wire.new("R8,U5,L5,D3")
w2 = Wire.new("U7,R6,D4,L4")
p = w1.intersections(w2).min
puts "Min Point: #{p} - distance: #{p.dist}"


# w3 = Wire.new("R75,D30,R83,U83,L12,D49,R71,U7,L72")
# w4 = Wire.new("U62,R66,U55,R34,D71,R55,D58,R83")
# p = w3.intersections(w4).min
# puts "Min Point: #{p} - distance: #{p.dist}"

# w4 = Wire.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
# U98,R91,D20,R16,D67,R40,U7,R15,U6,R7")



# File.open('day3.data').each do |line|
#   next if(line.nil?)
  
# end



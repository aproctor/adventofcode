#!/usr/bin/env ruby

#Hexagons = red blog games time https://www.redblobgames.com/grids/hexagons/

def distance(directions)
	x = 0
	y = 0

	directions.split(',').each do |d|
		if d == "n"
			y += -1		
		elsif d == "ne"
			x += 1
			y += -1
		elsif d == "se"
			x += 1
		elsif d == "s"
			y += 1
		elsif d == "sw"
			x += -1
			y += 1
		elsif d == "nw"
			x += -1
		else
			puts "Uknown direction #{d}"
		end	
	end

	puts "final position (#{x},#{y})"

	#Since we're doing a distance to 0,0 the axial co-ordinate distance formual is reduced	
    d = (x.abs + (x + y).abs + y.abs)/ 2

	d
end

# puts "#{distance("ne,ne,ne")}"
# puts "#{distance("ne,ne,sw,sw")}"
# puts "#{distance("ne,ne,s,s")}"
# puts "#{distance("se,sw,se,sw,sw")}"

File.open('day11.data').each do |line|
  continue if(line.nil?)

  puts "Part 1 - #{distance(line)}"
end




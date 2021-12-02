#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/2



x_pos = 0
y_pos = 0
commands = []
File.open('day2.data').each do |line|
  next if(line.nil?)
  md = line.match(/(down|forward|up) ([0-9]+)/)
  if(!md.nil?)
    dir = md[1].to_sym
    mag = md[2].to_i

    #part 1
    if dir == :down
    	y_pos -= mag
    elsif dir == :up
    	y_pos += mag
    elsif dir == :forward
    	x_pos += mag
    end	

    commands << {dir: dir, mag: mag}
  end
end

puts "Part 1:"
puts "(#{x_pos}, #{y_pos}) = #{(x_pos * y_pos).abs}"

puts "\nPart 2:"
x_pos = 0
y_pos = 0
aim = 0
commands.each do |c|
	if c[:dir] == :down
		aim += c[:mag]
	elsif c[:dir] == :up
		aim -= c[:mag]
	elsif c[:dir] == :forward
		#forward X does two things:
		#   It increases your horizontal position by X units.
		#   It increases your depth by your aim multiplied by X.

		x_pos += c[:mag]
		y_pos += aim * c[:mag]
	else
		puts "Uknown dir <#{dir}>"
	end
end
puts "(#{x_pos}, #{y_pos}) = #{(x_pos * y_pos).abs}"
#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/5

class BoardingPass
  attr_accessor :row, :seat

  def initialize(val)
    md = val.match(/([FB]{7})([RL]{3})/)
    @row = md[1].gsub("F","0").gsub("B","1").to_i(2)
    @seat = md[2].gsub("L","0").gsub("R","1").to_i(2)
    #puts "#{val} = #{@row}, #{@seat} = #{self.seat_id}"
  end

  def seat_id
  	(@row * 8) + @seat
  end
end

min_seat = 999999
max_seat = 0
all_passes = {}
File.open('day5.data').each do |line|
  next if(line.nil?)
  pass = BoardingPass.new(line)
  seat = pass.seat_id
  all_passes[seat] = pass

  max_seat = seat if(seat > max_seat)
  min_seat = seat if(seat < min_seat)
end

puts "Part 1 - Max Seat: #{max_seat}"

# Brute force part 2
(min_seat..max_seat).each do |i|
	if !all_passes.key?(i)
		puts "Part 2 - Open seat id at #{i}"
	end
end
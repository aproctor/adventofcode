#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/14

class Reindeer
  attr_accessor :given_name, :speed, :duration, :rest_time, :score

  def initialize(given_name, speed, duration, rest_time)
    @given_name = given_name
    @speed = speed
    @duration = duration
    @rest_time = rest_time
    @score = 0
  end

  def travel_distance(time)
  	total_distance = 0

  	unit_time = duration + rest_time
  	units = (time / unit_time).floor
  	complete_time = unit_time * units
  	# puts "#{time} - #{unit_time}, #{units}, #{complete_time}"

  	total_distance += units * speed * duration
   	total_distance += ([time - complete_time,duration].min) * speed

   	

  	total_distance
  end

  def print_travel(time)
  	puts "#{@given_name} travels #{travel_distance(time)}km after #{time}s"   	
  end

  def score_point
  	@score += 1
  end
end

puts "Part 1:"
# Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
comet = Reindeer.new("Comet", 14, 10, 127)

# Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
dancer = Reindeer.new("Dancer", 16, 11, 162)

comet.print_travel(2503)
dancer.print_travel(2503)

puts "\nPart 2:"

#stupid brute force method because why not
2503.times do |i|
	c = comet.travel_distance(i+1)
	d = dancer.travel_distance(i+1)
	if c > d
		comet.score_point
		last_dancer = false
	elsif d > c
		dancer.score_point
		last_dancer = true
	else
		puts "Tie at #{i+1}s"
		# Tie goes to both
		dancer.score_point
		comet.score_point
	end
end
puts "Comet Score:  #{comet.score}"
puts "Dancer Score: #{dancer.score}"
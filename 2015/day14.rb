#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/14

class Reindeer
  attr_accessor :given_name, :speed, :duration, :rest_time

  def initialize(given_name, speed, duration, rest_time)
    @given_name = given_name
    @speed = speed
    @duration = duration
    @rest_time = rest_time
  end

  def travel_distance(time)
  	total_distance = 0

  	unit_time = duration + rest_time
  	units = (time / unit_time).floor
  	complete_time = unit_time * units
  	# puts "#{time} - #{unit_time}, #{units}, #{complete_time}"

  	total_distance += units * speed * duration
   	total_distance += ([time - complete_time,duration].min) * speed

   	puts "#{@given_name} travels #{total_distance}km after #{time}s"   	

  	total_distance
  end
end

# Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
comet = Reindeer.new("Comet", 14, 10, 127)

# Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
dancer = Reindeer.new("Dancer", 16, 11, 162)

comet.travel_distance(2503)
dancer.travel_distance(2503)


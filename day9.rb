#!/usr/bin/env ruby
# Day 9
# See http://adventofcode.com/day/1

class City
  @@city_map = {}
  @@shortest_full_route_found = 9999999999
  @@longest_full_route_found = 0

  attr_reader :routes, :name

  def initialize(name)
    @name = name
    @routes = []
  end

  def self.join(from, to, distance)
    from_city = City.find(from)
    to_city = City.find(to)
    from_city.routes << Route.new(to_city, distance)
    to_city.routes << Route.new(from_city, distance)
  end

  def self.find(name)
    if(@@city_map[name].nil?)
      @@city_map[name] = City.new(name)
    end
    return @@city_map[name]
  end

  def self.traveling_santa
    @@city_map.each do |name,city|
      visted_cities = []

      #for each city
        # travel each route to another city, don't travel visited routes

      # find shortest distance to each other city in the city map through all other cities
    end
  end


  # def route_string
  #   puts "#{@name}: "
  #   @routes.each do |r|
  #     puts " -> #{r.destination.name}:#{r.distance}"
  #   end
  # end
end


class Route
  attr_reader :destination, :distance

  def initialize(dest, dist)
    @destination = dest
    @distance = dist
  end
end


File.open('day9.data').each do |line|
  continue if(line.nil?)

  md = line.match(/(\w+) -> (\w+) = (\d+)/)
  if(!md.nil?)
    City.join(md[1], md[2], md[3])
  end
end

City.shortest_distance()

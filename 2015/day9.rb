#!/usr/bin/env ruby
# Day 9
# See http://adventofcode.com/day/9

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

  def self.print_routes
    @@city_map.each do |name, city|
      city.print_route
    end
  end

  def self.possible_paths
    shortest_path = nil
    shortest_distance = nil
    longest_path = nil
    longest_distance = nil

    @@city_map.keys.permutation.each_with_index do |a,i|
      d = path_distance(a)
      puts "#{i}: #{a.join ' -> '} = #{d}"

      if(!d.nil?)
        if(shortest_distance.nil? || d < shortest_distance)
          shortest_path = a
          shortest_distance = d
        end
        if(longest_distance.nil? || d > longest_distance)
          longest_path = a
          longest_distance = d
        end
      end
    end

    puts "The shortest path is #{shortest_path.join(' -> ')} with a distance of #{shortest_distance}"
    puts "The longest path is #{longest_path.join(' -> ')} with a distance of #{longest_distance}"
  end

  def self.path_distance(path)
    total_distance = 0
    path.each_with_index do |c, i|
      break if(i == path.length - 1)
      city1 = @@city_map[c]
      city2 = @@city_map[path[i+1]]

      r = city1.route_to(city2)      
      return nil if(r.nil?)

      total_distance += r.distance
    end

    total_distance
  end

  def route_to(city)
    @routes.each do |r|
      if(r.destination == city)
        return r
      end
    end

    nil
  end

  def print_route
    puts "#{@name}: "
    @routes.each do |r|
      puts " -> #{r.destination.name}:#{r.distance}"
    end
  end
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

  md = line.match(/(\w+) to (\w+) = (\d+)/)
  if(!md.nil?)
    puts line
    City.join(md[1], md[2], md[3].to_i)
  end
end

City.print_routes
City.possible_paths

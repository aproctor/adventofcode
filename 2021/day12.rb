#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/12


class Cave
  attr_accessor :cave_id, :neighbours
  @@caves = {}

  def initialize(cave_id)
    @cave_id = cave_id
    @neighbours = []
  end

  def connect_to(other)
    #puts "Connecting #{self.cave_id} to #{other.cave_id}"
    @neighbours << other
    other.neighbours << self  
  end

  def start_node?
    self.cave_id == "start"
  end

  def end_node?
    self.cave_id == "end"
  end

  def big?
    Cave.big_cave_name?(self.cave_id)
  end

  def self.big_cave_name?(cave_id)
    cave_id.upcase == cave_id
  end

  def self.find_or_create(cave_id)     
    if !@@caves.has_key?(cave_id)
      @@caves[cave_id] = Cave.new(cave_id)
    end
    
    @@caves[cave_id]
  end

  
end


File.open('day12.data').each do |line|
  next if(line.nil?)
  md = line.match(/([A-Za-z]+)-([A-Za-z]+)/)
  if(!md.nil?)
    c1 = Cave.find_or_create(md[1])
    c2 = Cave.find_or_create(md[2])
    
    c2.connect_to(c1)
  end
end

puts "Part 1: routes"

start = Cave.find_or_create("start")

valid_paths = {}

# Seed possible paths with all neighbours of start
possible_paths = []
start.neighbours.each do |c|
  possible_paths << [start.cave_id, c.cave_id]
end

while possible_paths.length > 0 do
  new_paths = []

  possible_paths.each do |path|
    last_node = Cave.find_or_create(path[-1])

    if(last_node.end_node?)
      valid_paths[path.join(',')] = 1
    else
      last_node.neighbours.each do |n|

        can_visit = false
        if n.start_node?
          can_visit = false
        elsif n.end_node?
          can_visit = true
        elsif n.big?
          can_visit = true
        else
          tallies = path.tally
          if !tallies.has_key?(n.cave_id)
            can_visit = true
          else            
            can_visit = true #assume true unless too many hits found
            tallies.keys.each do |k|
              if tallies[k] > 1 && !Cave.big_cave_name?(k)
                can_visit = false
                break
              end
            end            
          end
        end        

        if can_visit
          p = path.dup
          p << n.cave_id
          new_paths << p
        end
      end
    end   
    
  end
  
  possible_paths = new_paths
end

# valid_paths.keys.sort.each do |path|
#   puts path
# end
puts "#{valid_paths.length} valid paths"







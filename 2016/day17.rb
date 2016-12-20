#!/usr/bin/env ruby
# Day 16 2016
# See http://adventofcode.com/2016/day/17

require 'digest/md5'

puts "Advent of Code 2016 day 17"

PASSCODE = "bwnlcvfs"
VALID_ORD = 'a'.ord
WIDTH = 4
HEIGHT = 4
MAX_ITERATIONS = 10000
TARGET_X = WIDTH - 1
TARGET_Y = HEIGHT - 1

def valid_paths(key, x, y, w, h)
  valid = []
  md5 = Digest::MD5.hexdigest(key)
  if(md5[0].ord > VALID_ORD && y > 0)
    valid << {direction: 'U', x: x, y: y - 1, key: key + 'U'}
  end
  if(md5[1].ord > VALID_ORD && y < HEIGHT - 1)
    valid << {direction: 'D', x: x, y: y + 1, key: key + 'D'}
  end
  if(md5[2].ord > VALID_ORD && x > 0)
    valid << {direction: 'L', x: x - 1, y: y, key: key + 'L'}
  end
  if(md5[3].ord > VALID_ORD && x < WIDTH - 1)
    valid << {direction: 'R', x: x + 1, y: y, key: key + 'R'}
  end

  return valid
end

#Breadth first search for shortest path to the vault at TARGET_X,TARGET_Y
potential_paths = valid_paths(PASSCODE, 0, 0, WIDTH, HEIGHT)
shortest_path = nil
MAX_ITERATIONS.times do |n|  
 
 new_paths = []
  potential_paths.each do |p|
    #puts "p: #{p.inspect}"
    if(p[:x] == TARGET_X && p[:y] == TARGET_Y)
      shortest_path = p
      break
    end

    new_paths.concat valid_paths(p[:key], p[:x], p[:y], WIDTH, HEIGHT)
  end

  potential_paths = new_paths

  #puts "#{n}: #{new_paths.length}"

  break if(!shortest_path.nil? || potential_paths.empty?)
end

if(shortest_path.nil?)
  puts "unable to find path after #{MAX_ITERATIONS} iterations"
else
  puts "shortest path was #{shortest_path}"
end


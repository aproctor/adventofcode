#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/12

File.open('day12.data').each_with_index do |line, l|
  next if(line.nil?)

  if(l == 0)
  	md = line.match(/initial state: ([#.]+)/)
  	if(!md.nil?)
      md[1].strip.each_char.each_with_index do |c, i|
	  	puts "#{i}: #{c}"
	  end
  	end
  else
  	md = line.match(/(..#.#) => (#)/)
  	next if md.nil?

  	
  end
end

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/5
require 'digest'

puts "Advent of Code 2016 day 5 part 2"


#part 1 - find 8-digit door code through searching increasing hashes
input = "cxdnnyjw"
password = []
found_keys = 0

MAX_ITERATIONS = 999999999
PASSWORD_LENGTH = 8
FILL_CHAR = '_'

PASSWORD_LENGTH.times do |x|
	password[x] = FILL_CHAR
end

MAX_ITERATIONS.times do |i|
  key = "#{input}#{i}"
  md5 = Digest::MD5.new
  out = md5.hexdigest key

  m = /^0{5}(\d)(.)/.match(out)
  if(!m.nil?)
  	index = m[1].to_i
  	if(index < PASSWORD_LENGTH && password[index] == FILL_CHAR)
	    password[index] = m[2]

	    puts "#{i}: #{password.join('')}"

	    found_keys += 1
	    break if(found_keys == PASSWORD_LENGTH)
	end
  end
end

puts "part 2: password is #{password.join('')}"
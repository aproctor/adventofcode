#!/usr/bin/env ruby
# Day 1 2016
# See http://adventofcode.com/2016/day/5
require 'digest'

puts "Advent of Code 2016 day 5"


#part 1 - find 8-digit door code through searching increasing hashes
input = "cxdnnyjw"
password = []

MAX_ITERATIONS = 999999999
PASSWORD_LENGTH = 8

MAX_ITERATIONS.times do |i|
  key = "#{input}#{i}"
  md5 = Digest::MD5.new
  out = md5.hexdigest key

  m = /^0{5}(.)/.match(out)
  if(!m.nil?)
    password << m[1]

    puts "#{i}: #{m[1]}"

    break if(password.length == PASSWORD_LENGTH)
  end
end

puts "part 1: password is #{password.join('')}"
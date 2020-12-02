#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/2

class Password
  attr_accessor :val, :min, :max, :limit_char

  def initialize(mn, mx, c, v) 
    @min = mn
    @max = mx
    @limit_char = c
    @val = v
  end

  def p1_valid?
  	count = 0
  	@val.each_char do |c|
  		count += 1 if c == @limit_char
  	end

  	count <= @max && count >= @min
  end

  def p2_valid?
  	return false if @max > @val.length

  	count = 0
  	count += 1 if @val[@min-1] == @limit_char
  	count += 1 if @val[@max-1] == @limit_char

  	count == 1
  end
end


passwords = []
p1_valid_count = 0
p2_valid_count = 0
File.open('day2.data').each do |line|
  next if(line.nil?)

  #1-3 a: abcde
  md = line.match(/([0-9]+)-([0-9]+) ([a-zA-Z]): ([a-zA-Z]+)/)
  if(!md.nil?)
  	pass = Password.new(md[1].to_i, md[2].to_i, md[3], md[4])
  	passwords << pass

  	p1_valid_count += 1 if pass.p1_valid?
  	p2_valid_count += 1 if pass.p2_valid?
  end
end

puts "Part 1: #{p1_valid_count} of #{passwords.length} are valid"
puts "Part 2: #{p2_valid_count} of #{passwords.length} are valid"



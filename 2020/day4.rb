#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/4

class Passport
  def initialize()
  	@data = {}
  end

  def append(line)
  	line.split(' ').each do |entry|
  		vals = entry.split(':')
  		@data[vals[0]] = vals[1]
  	end
  end

  def p1_valid?  	
		# byr (Birth Year)
		# iyr (Issue Year)
		# eyr (Expiration Year)
		# hgt (Height)
		# hcl (Hair Color)
		# ecl (Eye Color)
		# pid (Passport ID)
		# cid (Country ID) (now optional)
		key_exists("byr") && key_exists("iyr") && key_exists("eyr") && key_exists("hgt") && key_exists("hcl") && key_exists("ecl") && key_exists("pid")
  end

  private

  def key_exists(k)
  	valid = @data.key?(k)
  	# puts "Missing #{k}" if(!valid)

  	return valid
  end
end

passports = []
pass = Passport.new()

File.open('day4.data').each do |line|
  next if(line.nil?)
  
  if(line == "\n")
  	passports << pass

  	pass = Passport.new()
  else
  	pass.append(line)
  end
end

p1_total_valid = 0
passports.each do |p|
	p1_total_valid += 1 if p1.p1_valid?
end
puts "Part 1: #{p1_total_valid}"


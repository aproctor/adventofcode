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
		key_exists?("byr") && key_exists?("iyr") && key_exists?("eyr") && key_exists?("hgt") && key_exists?("hcl") && key_exists?("ecl") && key_exists?("pid")
  end

  def p2_valid?  	
  	valid = true

		# byr (Birth Year): 1920-2002
		valid = valid && valid_year?("byr", 1920, 2002)
		
		# iyr (Issue Year): 2010-2020
		valid = valid && valid_year?("iyr", 2010, 2020)
		
		# eyr (Expiration Year): 2020-2030
		valid = valid && valid_year?("eyr", 2020, 2030)
		
		# hgt (Height): a number followed by either cm or in
		valid = valid && valid_height?

		# hcl (Hair Color): a # followed by exactly six characters 0-9 or a-f
		valid = valid && valid_pattern?("hcl", /^#[0-9a-f]{6}$/)
		
		# ecl (Eye Color): exactly one of amb blu brn gry grn hzl oth
		valid = valid && valid_pattern?("ecl", /^(amb|blu|brn|gry|grn|hzl|oth)$/)
		
		# pid (Passport ID): a nine-digit number, including leading zeroes
		valid = valid && valid_pattern?("pid", /^[0-9]{9}$/)
		
		# cid (Country ID) (now optional): ignored, missing or not
		
		valid
  end

  private

  def key_exists?(k)
  	valid = @data.key?(k)
  	# puts "Missing #{k}" if(!valid)

  	return valid
  end

  def valid_year?(k, min, max)
  	valid = true
  	if(key_exists?(k))
			year = @data[k].to_i
			valid = valid && year >= min && year <= max
		else
			valid = false
		end
		valid
  end

  def valid_height?(verbose = false)
  	valid = true

  	# hgt (Height): a number followed by either cm or in
		if(key_exists?("hgt"))
			md = @data["hgt"].match(/([0-9]+)(in|cm)/)
			if(md.nil?)
				#puts "Invalid Height string: #{@data["hgt"]}"
				valid = false
			else
				h = md[1].to_i
				unit = md[2]

				if(md[2] == "cm")
					#If cm, the number must be at least 150 and at most 193.					
					valid = h >= 150 && h <= 193
				else
					#If in, the number must be at least 59 and at most 76
					valid = h >= 59 && h <= 76
				end			
			end

			puts "invalid height: #{@data['hgt']}" if !valid && verbose

		else
			puts "Missing Height" if(verbose)
			valid = false
		end

		valid
  end

  def valid_pattern?(k, pattern)
  	#return key_exists?(k) && !@data[k].match(pattern).nil?
  	return false if(!key_exists?(k))

  	md = @data[k].match(pattern)
  	if(md.nil?)
  		puts "Invalid pattern: #{k}:#{@data[k]}"
  		return false  	
  	end

  	true
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
p2_total_valid = 0
passports.each do |p|
	p1_total_valid += 1 if p.p1_valid?
	p2_total_valid += 1 if p.p2_valid?
end
puts "Part 1: #{p1_total_valid}"
puts "Part 2: #{p2_total_valid}"


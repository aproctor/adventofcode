#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/4


def p1_valid?(pass)
	keys = pass.each_char.map(&:to_i)
	last = 0
	dupe_found = false
	keys.each do |key|
		#must always increase
		return false if key < last

		dupe_found = true if key == last

		last = key
	end	
	return dupe_found
end

def p2_valid?(pass)
	keys = pass.each_char.map(&:to_i)
	last = 0
	dupes_found = 0
	uneven_chain = false
	chain_count = 0
	keys.each do |key|
		#must always increase
		return false if key < last

		if(key == last)
			if(chain_count == 0)
				dupes_found += 1
			else
				dupes_found -= 1 if(chain_count == 1)
			end
			chain_count += 1
		else
			chain_count = 0
		end

		last = key
	end	

	return dupes_found > 0
end

# puts p1_valid?("111111")
# puts p1_valid?("223450")
# puts p1_valid?("123789")

# puts p2_valid?("112233")
# puts p2_valid?("123444")
# puts p2_valid?("111122")

p1_passwords = []
p2_passwords = []
input = "171309-643603"
range = input.split("-").map(&:to_i)
(range[0]..range[1]).each do |i|
	pass = i.to_s
	if(p1_valid?(pass))
		# puts "Valid: #{pass}"
		p1_passwords << pass
	end
	if(p2_valid?(pass))
		# puts "Valid: #{pass}"
		p2_passwords << pass
	end
end
puts "P1 Count: #{p1_passwords.count}"
puts "P2 Count: #{p2_passwords.count}"

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end

#!ruby
# Day 4
# See http://adventofcode.com/day/4

require 'digest/md5'

SAFETY = 1000000

def find_lowest_num(key)
	num = 0
	while(num < SAFETY) do
		result = Digest::MD5.hexdigest("#{key}#{num}")
		if(!result.match(/^00000/).nil?)
			puts "Found  <#{result}> at num <#{num}>"
			return num
		end

		num += 1		
	end

	return nil
end

puts "Part 1 Searching..."
puts find_lowest_num("ckczppom")
puts "Done"
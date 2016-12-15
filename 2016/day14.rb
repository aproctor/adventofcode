#!/usr/bin/env ruby
# Day 14
# See http://adventofcode.com/2016/day/14

require 'digest/md5'

TARGET_KEY = 64
MAX_ATTEMPTS = 1000000
MAX_KEY_DISTANCE = 1000

#salt = "cuanljph"
salt = "abc"

#result = 

found_keys = []
potential_keys = {}

def key_data(key, i)
	trips = []
	quints = []

	prev_char = ''
	repeat_count = 0
	key.each_char do |c|
		if(c == prev_char)
			repeat_count += 1
			if(repeat_count == 2)
				trips << c
			elsif(repeat_count == 4)
				quints << c
			end
		else
			repeat_count = 0
		end

		prev_char = c
	end

	return {num: i, key: key, trips: trips, quints: quints}
end	

MAX_ATTEMPTS.times do |num|
	
	key = Digest::MD5.hexdigest("#{salt}#{num}")

	kd = key_data(key, num)

	match_found_for_key = false
	kd[:quints].each do |q|
		break if(match_found_for_key)
		potential_keys.each do |k,v|
			if(v[:trips].include?(q))
				#puts "#{v} found for #{kd}"
				found_keys << v
				match_found_for_key = true
				break
			end
		end
	end

	if(!kd[:trips].empty?)
		potential_keys[num] = kd
	end

	if(potential_keys.key?(num - MAX_KEY_DISTANCE))
		potential_keys.delete(num - MAX_KEY_DISTANCE)
	end	

end	

indexes = found_keys.map { |k| k[:num]}.sort
puts "#{indexes[63]}"
#puts "part 1 - #{TARGET_KEY}th key index: #{indexes[TARGET_KEY]}"
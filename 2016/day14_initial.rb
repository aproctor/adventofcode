#!/usr/bin/env ruby
# Day 14
# See http://adventofcode.com/2016/day/14

require 'digest/md5'

TARGET_KEYS = 64
MAX_ATTEMPTS = 2500000
MAX_KEY_DISTANCE = 1000
HASH_TIMES = 2017

salt = "cuanljph"
#salt = "abc"

#result = 

found_keys = {}
potential_keys = {}

cache = {}
def md5_val(key, md5_key_cache)
	if(!md5_key_cache.key?(key))
		md5_key_cache[key] = Digest::MD5.hexdigest(key)	
	end	

	md5_key_cache[key]
end

def key_data(key, i)
	trips = []
	quints = []

	prev_char = ''
	repeat_count = 0
	key.each_char do |c|
		if(c == prev_char)
			repeat_count += 1
			if(repeat_count == 2 && trips.empty?)
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

max_index = nil
MAX_ATTEMPTS.times do |num|
	break if(!max_index.nil? && num > max_index)

	puts "#{num} - #{found_keys.length}" if num % 1000 == 0
	
	key = "#{salt}#{num}"
	HASH_TIMES.times do |i|
	 key = md5_val(key, cache)
	end

	kd = key_data(key, num)

	kd[:quints].each do |q|
		potential_keys.each do |k,v|
			if(v[:trips].include?(q))
				#puts "#{v} found for #{kd}"
				found_keys[num] = v
			end
		end
	end

	if(!kd[:trips].empty?)
		potential_keys[num] = kd
	end

	if(potential_keys.key?(num - MAX_KEY_DISTANCE))
		potential_keys.delete(num - MAX_KEY_DISTANCE)
	end	

	if(max_index.nil? && found_keys.length >= TARGET_KEYS)
		max_index = num + 1000
	end

end	

indexes = found_keys.values.map { |k| k[:num]}.sort
puts "#{indexes}"
puts "#{indexes[TARGET_KEYS-1]}"

#puts "part 1 - #{TARGET_KEYS}th key index: #{indexes[TARGET_KEYS]}"
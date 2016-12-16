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

found_keys = []
potential_keys = {}

key_cache = {}
key_data_cache = {}

def key_data(key, i, cache)
	if(!cache.key?(key))
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

		cache[key] = {num: i, key: key, trips: trips, quints: quints}
	end

	return cache[key]
end	

def get_key(input, key_cache)
	if(!key_cache.key?(input))
		key = input
		HASH_TIMES.times do |i|
		 key = Digest::MD5.hexdigest(key)
		end
		key_cache[input] = key
	end
	return key_cache[input]
end

max_index = nil
MAX_ATTEMPTS.times do |num|
	break if(!max_index.nil? && num > max_index)

	puts "#{num} - #{found_keys.length}" if num % 1000 == 0
	
	key = get_key("#{salt}#{num}", key_cache)
	kd = key_data(key, num, key_data_cache)

	if(!kd[:trips].empty?)
		t = kd[:trips].first
		1000.times do |x|			
			key2 = get_key("#{salt}#{num+x+1}", key_cache)
			kd2 = key_data(key2, num+x+1, key_data_cache)
			if(kd2[:quints].include?(t))
				puts "found one #{num}"
				found_keys << kd
				break
			end
		end
	end

	break if(found_keys.length >= TARGET_KEYS)
end	

indexes = found_keys.map { |k| k[:num]}
puts "#{indexes}"
puts "#{indexes[TARGET_KEYS-1]}"

#puts "part 1 - #{TARGET_KEYS}th key index: #{indexes[TARGET_KEYS]}"
#!ruby
# Day 5
# See http://adventofcode.com/day/5


def is_nice_v1?(word)
	# It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.  
	return false if(word.match(/ab/) || word.match(/cd/) || word.match(/pq/) || word.match(/xy/))

	# It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
	return false if(word.match(/[aeiou].*[aeiou].*[aeiou]/).nil?)

	# It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
	letter_count = {}
	word.each_char do |c|
		letter_count[c] = letter_count[c].to_i + 1
	end

	letter_count.each do |k,v|
		if(v > 1)
			return true if(word.match("#{k}#{k}"))
		end
	end

	return false	
end


def is_nice_v2?(word)
	match = nil
	pair = nil

	#Count letters
	letter_count = {}
	word.each_char do |c|
		letter_count[c] = letter_count[c].to_i + 1
	end

	#It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
	found_match = false
	letter_count.each do |k,v|		
		if(v > 1 && word.match("#{k}.#{k}"))
			found_match = true
			match = word.match("#{k}.#{k}")
			break
		end
	end
	return false if(!found_match)

	###
	# Rule 2:
	#  It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
	##
	all_pairs = {}
	letter_count.each do |k,v|		
		if(v > 1)
			#all_pairs = word.scan(Regexp.new("#{k}.")).sort
			#scan isn't getting all matches (ie: qqj should return qq and qj but it doesn't)			
			prev_match = false
			i = 0
			word.each_char do |c|
				if(prev_match)
					pair = "#{k}#{c}"
					all_pairs[i] = pair					
				end
				prev_match = (c == k)	
				i += 1
			end
		end		
	end

	#Search for letters combos that aren't overlapping
	last_pair = nil
	last_index = -1
	last_pair_overlapped = false
	all_pairs.sort_by {|_key, value| value}.to_h.each do |i, pair|
		if(pair == last_pair)
			#check if pair overlaps
			if((last_index-i).abs > 1)				
				#no overlap
				return true
			elsif(last_pair_overlapped)
				#overlap, but the pair before that also overlapped eg: wwww
				return true
			else
				last_pair_overlapped = true
			end
		else
			#pairs don't match
			#we need to unset the tripplet detecting bool
			last_pair_overlapped = false
		end

		last_pair = pair
		last_index = i
	end	


	return false	
end



#part 1
num_nice = 0
File.open('day5.data').each do |line|
	if(is_nice_v1?(line))
		num_nice += 1 
	end
end
puts "Part 1 - Num Nice: #{num_nice}"

#Checks
# puts is_nice_v2?("qjhvhtzxzqqjkmpb") #true
# puts is_nice_v2?("xxyxx") #true
# puts is_nice_v2?("uurcxstgmygtbstg") #false
# puts is_nice_v2?("ieodomkazucvgmuy") #false

#part 2
num_nice = 0
File.open('day5.data').each do |line|
	if(is_nice_v2?(line))
		num_nice += 1 
	end
end
puts "Part 2 - Num Nice: #{num_nice}"


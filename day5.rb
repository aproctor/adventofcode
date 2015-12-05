#!ruby
# Day 5
# See http://adventofcode.com/day/5


def is_nice?(word)
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


#part 1
num_nice = 0
File.open('day5.data').each do |line|
	if(is_nice?(line))
		num_nice += 1 
	end
end

puts "Num Nice: #{num_nice}"
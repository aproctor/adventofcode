#!/usr/bin/env ruby

def p1_score_stream(stream)
	score = 0
	depth = 0
	in_garbage = false
	in_negation = false


	stream.each_char do |c|
		if(in_negation)  		
			in_negation = false
			next
		elsif(in_garbage)
			if(c == '>')  			
				in_garbage = false
			elsif c == '!'
				in_negation = true
			end

			next
		end

		if c == '{'
			depth += 1
		elsif c == '}'
			score += depth
			depth -= 1
		elsif c == '<'
			in_garbage = true
		end

		if(depth < 0)
			puts "WTF: depth < 0"
			break
		end
	end

	score
end

File.open('day9.data').each do |line|
	continue if(line.nil?)  

	puts "Part 1 - #{p1_score_stream(line)}"
end


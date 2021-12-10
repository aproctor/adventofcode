#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/10

lines = []
File.open('day10.data').each do |line|
  next if(line.nil?)
  lines << line.strip
end

PARENS = {}
PARENS["("] = ")"
PARENS["["] = "]"
PARENS["{"] = "}"
PARENS["<"] = ">"

P1_SCORES = {}
P1_SCORES[")"] = 3
P1_SCORES["]"] = 57
P1_SCORES["}"] = 1197
P1_SCORES[">"] = 25137

P2_SCORES = {}
P2_SCORES[")"] = 1
P2_SCORES["]"] = 2
P2_SCORES["}"] = 3
P2_SCORES[">"] = 4

p1_score = 0
p2_scores = []
lines.each do |line|
	stack = []	
	valid = true
	line.each_char do |c|
		if PARENS.key?(c)
			stack << PARENS[c]
		else
			last_char = stack.pop
			if c != last_char				
				# puts "#{line} - Expected #{last_char}, but found #{c} instead."
				p1_score += P1_SCORES[c]
				valid = false
				break
			end
		end
	end
    
	if valid
		line_score = 0
		remainder = stack.join('')
		while stack.length > 0 do
			line_score *= 5
			line_score += P2_SCORES[stack.pop]
		end
		# puts "#{remainder} - #{line_score}"

		p2_scores << line_score
	end
end

p2_scores.sort!
mid_point = (p2_scores.length / 2).floor
p2_score = p2_scores[mid_point]

puts "Part 1: #{p1_score}"
puts "Part 2: #{p2_score}"
#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/19

def elements_for_seq(input_sequence)
	elements = []

	last_char = nil
	cur_element = ""
	
	input_sequence.each_char do |c|		
		if(c < "a")
			# Capital letters have lower ord values than lowercase
			#start of a new element
			elements << cur_element if cur_element.length > 0

			cur_element = c
		else
			cur_element << c			
		end
		last_char = c
	end
	elements << cur_element

	elements
end

def unique_combos(input_sequence, transformers)
	uniques = {}

	elements = elements_for_seq(input_sequence)
	elements.each_with_index do |e, i|		
		if transformers.key?(e)
			transformers[e].each do |s|
				elements[i] = s

				str = elements.join('')
				uniques[str] = 1
			end

			#set back to default for future analysis
			elements[i] = e
		end
	end

	# puts uniques.inspect

	uniques.keys.length
end


transformers = {}
sequence = nil
File.open('day19.data').each do |line|
  next if(line.nil?)
  line.strip!
  next if(line.length == 0)

  md = line.match(/(\w+) => (\w+)/)
  if(!md.nil?)
  	if(transformers.key?(md[1]))
  		transformers[md[1]] << md[2]	
  	else
  		transformers[md[1]] = [md[2]]
  	end
  else
  	sequence = line
  end  
end

puts unique_combos(sequence, transformers)


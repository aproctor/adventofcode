#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/8

MAX_ITERATIONS = 10000

#Part 1
instructions = []
cur_instruction = 0
acc = 0

File.open('day8.data').each do |line|
  next if(line.nil?)

  instructions << line.split(' ')
end

visited_addresses = {}
MAX_ITERATIONS.times do |x|
	if(visited_addresses.key?(cur_instruction))
		puts "Already executed instruction on line #{cur_instruction}"
		break
	end
	if(cur_instruction >= instructions.length)
		puts "EOF"
		break
	elsif(cur_instruction < 0)
		puts "Out of bounds, freak out! #{cur_instruction}"
		break
	end
	visited_addresses[cur_instruction] = 1

	ins = instructions[cur_instruction]
	#puts "#{cur_instruction}: #{ins.inspect} | #{x}"
	if(ins[0] == "acc")
		acc += ins[1].to_i
		cur_instruction += 1
	elsif(ins[0] == "nop")
		cur_instruction += 1
	elsif(ins[0] == "jmp")
		cur_instruction += ins[1].to_i
	else
		puts "Unrecognized command #{ins.inspect}"
		break
	end
end
puts "Part 1: #{acc}"


# Part 2 - now with substitution
eof_found = false
visited_addresses.keys.each do |i|
	puts "Changing Line: #{i} #{instructions[i].inspect}"
	was_jump = false
	if(instructions[i][0] == "jmp")		
		was_jump = true
		instructions[i][0] = "nop"
	elsif(instructions[i][0] == "nop")
		instructions[i][0] = "jmp"
	else
		# skip this instruction it can't be changed
		next
	end

	acc = 0
	cur_instruction = 0
	new_visited_addresses = {}
	MAX_ITERATIONS.times do |x|
		if(new_visited_addresses.key?(cur_instruction))
			puts "Already executed instruction on line #{cur_instruction}"
			break
		end
		if(cur_instruction >= instructions.length)
			puts "EOF"
			eof_found = true
			break
		elsif(cur_instruction < 0)
			puts "Out of bounds, freak out! #{cur_instruction}"
			break
		end
		new_visited_addresses[cur_instruction] = 1

		ins = instructions[cur_instruction]
		puts "#{cur_instruction}: #{ins.inspect} | #{x}"
		if(ins[0] == "acc")
			acc += ins[1].to_i
			cur_instruction += 1
		elsif(ins[0] == "nop")
			cur_instruction += 1
		elsif(ins[0] == "jmp")
			cur_instruction += ins[1].to_i
		else
			puts "Unrecognized command #{ins.inspect}"
			break
		end
	end

	if(eof_found == true)
		puts "Changing line #{i} fixed our loop"
		break	
	end

	#swap instruction back to normal for next run
	if(instructions[i][0] == "jmp")		
		was_jump = true
		instructions[i][0] = "nop"
	elsif(instructions[i][0] == "nop")
		instructions[i][0] = "jmp"
	end

end
puts "Part 2: #{acc}"
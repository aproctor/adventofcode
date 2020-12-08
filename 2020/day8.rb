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
	if(cur_instruction < 0 || cur_instruction >= instructions.length)
		puts "Out of bounds, freak out! #{cur_instruction}"
		break
	end
	visited_addresses[cur_instruction] = 1

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
puts "Part 1: #{acc}"
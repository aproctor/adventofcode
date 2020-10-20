#!/usr/bin/env ruby
# See http://adventofcode.com/2019/day/7

#no infinite loops in NASA, same safety for Santa in space
MAX_ITERATIONS = 100000
STOP_CMD = 99
ADD_CMD = 1
MUL_CMD = 2
IN_CMD = 3
OUT_CMD = 4
JMP_CMD = 5
JMP_FALSE_CMD = 6
LESS_THAN_CMD = 7
EQUALS_CMD = 8

def intcode(buffer, input)
	# puts "Input: #{input.join(', ')}"
 #  puts buffer.join(', ')
  output = nil

  i = 0
  MAX_ITERATIONS.times do
    break if i >= buffer.count || buffer[i] == STOP_CMD

    #convert first 2 digits to comand and modes
    modes = buffer[i].digits
    cmd = modes.shift + (modes.shift || 0) * 10

    #puts "#{i}: #{buffer[i]}"

    if(cmd == ADD_CMD || cmd == MUL_CMD || cmd == LESS_THAN_CMD || cmd == EQUALS_CMD)
    	v1 = value_for(modes.shift, i+1, buffer)
    	v2 = value_for(modes.shift, i+2, buffer)

    	#Parameters that an instruction writes to will never be in immediate mode.
   	  t = buffer[i+3]

   	  if(cmd == ADD_CMD)
      	buffer[t] = v1 + v2
      	#puts "\t#{v1} + #{v2} = #{buffer[t]} -> #{t}"
      elsif(cmd == MUL_CMD)
      	buffer[t] = v1 * v2
      	#puts "\t#{v1} * #{v2} = #{buffer[t]} -> #{t}"
      elsif(cmd == LESS_THAN_CMD)
      	buffer[t] = (v1 < v2) ? 1 : 0
      elsif(cmd == EQUALS_CMD)
      	buffer[t] = (v1 == v2) ? 1 : 0	
      end

      #the instruction pointer should increase by the number of values in the instruction
      i += 4
    elsif(cmd == IN_CMD)    	
    	t = buffer[i+1]
    	buffer[t] = input.shift
    	#puts "Storing #{buffer[t]} at #{t}"
    	i += 2
    elsif(cmd == OUT_CMD)
    	output = value_for(modes.shift, i+1, buffer)
    	#if out is invalid check last statement
    	#puts output
    	i += 2
    elsif(cmd == JMP_CMD)
    	if(value_for(modes.shift, i+1, buffer) != 0)
    		i = value_for(modes.shift, i+2, buffer)
    	else
    		i += 3
    	end
    elsif(cmd == JMP_FALSE_CMD)
    	if(value_for(modes.shift, i+1, buffer) == 0)
    		i = value_for(modes.shift, i+2, buffer)
    	else
    		i += 3
    	end
    else
      puts "unknown command at #{i} -> #{cmd}"
      break
    end
  end

  # puts "= #{buffer.join(',')}"

  output
end

def value_for(mode, i, buffer)
	#immediate mode = 1, default and 0 are position mode
	index = buffer[i]
	(mode == 1) ? index : buffer[index]
end


def find_permutations(vals)
	return vals if(vals.length <= 1)

	all_permutes = []
	vals.each do |v|		
		others = []
		vals.each do |v2|
			others << v2 if v2 != v
		end
		other_permutes = find_permutations(others)
		other_permutes.each do |o|
			new_permute = [v]
			new_permute.push(*o)
			#puts "New Permute: #{new_permute.join(',')}"
			all_permutes.push(new_permute)
		end
	end

	all_permutes
end

puts "Part 1"
#program = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
#program = [3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0]
#program = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]
program = [3,8,1001,8,10,8,105,1,0,0,21,38,47,72,97,122,203,284,365,446,99999,3,9,1001,9,3,9,1002,9,5,9,1001,9,4,9,4,9,99,3,9,102,3,9,9,4,9,99,3,9,1001,9,2,9,102,5,9,9,101,3,9,9,1002,9,5,9,101,4,9,9,4,9,99,3,9,101,5,9,9,1002,9,3,9,101,2,9,9,102,3,9,9,1001,9,2,9,4,9,99,3,9,101,3,9,9,102,2,9,9,1001,9,4,9,1002,9,2,9,101,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99]

max_output = -99999
sequence = nil
all_permutes = find_permutations([0,1,2,3,4])
all_permutes.each do |p|
	aVal = intcode(program.dup, [p[0],0])
	bVal = intcode(program.dup, [p[1],aVal])
	cVal = intcode(program.dup, [p[2],bVal])
	dVal = intcode(program.dup, [p[3],cVal])
	eVal = intcode(program.dup, [p[4],dVal])

	#puts "#{p.join(',')} -> #{eVal}"
	if(eVal > max_output)
		max_output = eVal
		sequence = p
	end
end
puts "Max Output: #{max_output}, #{sequence.join(',')}"

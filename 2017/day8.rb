#!/usr/bin/env ruby

class Instruction

	attr_reader :address, :operation, :amount, :condition_left, :operator, :condition_right


	def initialize(address, operation, amount, condition_left, operator, condition_right)
		@address = address
		@operation = operation
		@amount = amount
		@condition_left = condition_left
		@operator = operator
		@condition_right = condition_right
	end

	def valid?(registers)
		evaluation = false
		
		if(@operator == "!=")
			evaluation = registers[@condition_left].to_i != @condition_right
		elsif(@operator.end_with?("="))
			evaluation ||= registers[@condition_left].to_i == @condition_right
		end
		if(@operator.start_with?("<"))
			evaluation ||= registers[@condition_left].to_i < @condition_right
		end
		if(@operator.start_with?(">"))
			evaluation ||= registers[@condition_left].to_i > @condition_right
		end

		evaluation
	end

	def run(registers)
		value = registers[@address].to_i

		if(valid?(registers))
			if(@operation == :inc)
				value += amount
			elsif @operation == :dec
				value += -amount
			end

			registers[@address] = value
		end

		value
	end
end

instructions = []
File.open('day8.data').each do |line|
  continue if(line.nil?)  

  md = line.match(/(\w+) (inc|dec) (-?\d+) if (\w+) ([<>=!]=?) (-?\d+)/)  
  
  #puts "line: #{line}, md: #{md}" if(md.nil?)
  ins = Instruction.new(md[1], md[2].to_sym, md[3].to_i, md[4], md[5], md[6].to_i)
  #puts "#{ins.inspect}"
  instructions << ins
end


#Part 1
registers = {}
max_value = 0
instructions.each do |ins|
	val = ins.run(registers)
	max_value = val if(val > max_value)
end

puts "Part 1 - Max value #{registers.values.max}"
puts "Part 2 - Max ever value #{max_value}"

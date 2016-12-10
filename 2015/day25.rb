#!ruby
# Day 25
# See http://adventofcode.com/day/25

#part 1 - enter code from diagonal box thing

MAX_ITERATIONS = 999999999

def find_value_at(target_row, target_column, initial_value, scale, divisor, increment)	
	puts "\nFind (#{target_row},#{target_column}):"

	i = 0
	row = 1
	col = 1
	current_size = 1
	diagonal_size = 1

	current_value = initial_value
	while(i < MAX_ITERATIONS) do
		previous_value = current_value
		
		#puts "(#{row},#{col}) = #{current_value}"

		if(row == target_row && col == target_column)
			return current_value
		end

		current_value = (previous_value * scale) + increment
		current_value = current_value % divisor if(divisor != 0)

		if(current_size < diagonal_size)
			current_size += 1
			row -= 1
			col += 1
		else
			diagonal_size += 1
			row = diagonal_size
			col = 1
			current_size = 1
		end


		i += 1
	end

	#unable to find value, ran out of allowed iterations
	return nil
end

#puts find_value_at(3,4, 1, 1, 0, 1)
#puts find_value_at(2,3, 20151125, 252533, 33554393, 0)
puts find_value_at(3010,3019, 20151125, 252533, 33554393, 0)
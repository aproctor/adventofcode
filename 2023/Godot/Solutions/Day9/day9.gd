extends Day

class_name Day9

func find_next_value(sequence):
	var found_delta = false
	print("Finding value for sequence %s" % [sequence])
	var last_digits = []
	last_digits.append(sequence[-1])
	var cur_sequence = sequence
	
	for d in sequence.size(): # max depth of full traversal
		var delta = delta_sequence(cur_sequence)		
		#print("delta: %s" % [delta])
		
		if(delta == null || delta.size() == 0):
			break
		
		last_digits.push_front(delta[-1])
		cur_sequence = delta
	
	#print("last digits: %s" % [last_digits])

	return last_digits.reduce(array_summer, 0)

func array_summer(accum, number):
	return accum + number
	
func delta_sequence(input_sequence):
	var all_zeros = true
	var delta = []
	for i in input_sequence.size()-1:
		var diff = input_sequence[i+1] - input_sequence[i]
		if(diff != 0):
			all_zeros = false
		delta.append(diff)
	
	if(all_zeros):
		return null
	
	return delta

func part_1(input):
	var total = 0;
	var output = ""
		
	var dataRegex = RegEx.new();
	dataRegex.compile("\\d+")
	
	for input_line in input.split("\n"):
		var sequence = input_line.split_floats(" ", false)
		if(sequence.size() > 0):
			var next_value = find_next_value(sequence)		
			output += "Next value for %s is %d\n" % [sequence, next_value]
			total += next_value	
	
	output += "Total = " + str(total)	
	finish(output)


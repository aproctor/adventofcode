extends Day

class_name Day1

func part_1(input) -> String:
	var total = 0;
	var output = ""
		
	var first_char_regex = RegEx.new()
	first_char_regex.compile("^[a-z]*(\\d)")
	
	var last_char_regex = RegEx.new()
	last_char_regex.compile("(\\d)[a-z]*$")
		
	for input_line in input.split("\n"):
		if(input_line.length() > 0):
			print(input_line)
			var first_result = first_char_regex.search(input_line)
			var last_result = last_char_regex.search(input_line)
			if(first_result && last_result):
				output += "%s-> %s%s\n" % [input_line, first_result.get_string(1), last_result.get_string(1)]
				total += int("%s%s" % [first_result.get_string(1), last_result.get_string(1)])
	
	output += "Total: " + str(total)
		
	return output

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

func part_2(input) -> String:
	var total = 0;
	var output = ""
	
	var first_digit_index = 99999;
	var first_digit = "";
	
	var last_digit_index = -1;
	var last_digit = "";
	
	var digit_map = {
		"one": "1",
		"two": "2",
		"three": "3",
		"four": "4",
		"five": "5",
		"six": "6",
		"seven": "7",
		"eight": "8",
		"nine": "9"
	};
	
	var word_digit_regex = RegEx.new()
	word_digit_regex.compile("("+"|".join(digit_map.keys())+"|\\d)")
	
	for n in 9:
		digit_map[str(n+1)] = str(n+1)
	
	for input_line in input.split("\n"):
		if(input_line.length() > 0):
			print(input_line)
			var digit_results = word_digit_regex.search_all(input_line)
			if(digit_results && digit_results.size() > 0):
				#output += input_line + "\n"
				#for digit_match in digit_results:
				#	output += "Digit : %s found at %d\n" % [digit_match.get_string(), digit_match.get_start()]
				var first = digit_map[digit_results[0].get_string()]
				var last = digit_map[digit_results[-1].get_string()]
				var value =  int("%s%s" % [first, last])
				output += "First: %s, Last: %s, Value: %d\n" % [first, last, value]				
				total += value
	
	output += "Total: " + str(total)
		
	return output

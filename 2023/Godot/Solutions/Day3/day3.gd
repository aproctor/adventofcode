extends Day

class_name Day3

func coord(x, y):
	return "%d,%d" % [x, y]
	
func adjacent_keys(coordinate):
	
	var raw = coordinate.split(",")
	var x = int(raw[0])
	var y = int(raw[1])
	
	var result = [coord(x-1,y-1), coord(x, y-1), coord(x+1, y-1),
				  coord(x-1,y), coord(x+1, y),
				 coord(x-1, y+1), coord(x, y+1), coord(x+1, y+1)];
	
	return result;

func part_1(input) -> String:
	var total = 0;
	var output = ""
	
	var part_map = {}
	var symbol_map = {}
	var parts_list = []
	
	var number_regex = RegEx.new()
	number_regex.compile("(\\d+)")
	
	# Process Map
	var y = 0;
	for input_line in input.split("\n"):
		var x = 0
		
		var number_matches = number_regex.search_all(input_line)
		for number_match in number_matches:
			output += "Number found %s %d\n" % [number_match.get_string(), number_match.get_start()]
			var new_part = ToolPart.new(number_match.get_string(), number_match.get_start(), y)
			parts_list.append(new_part)
		
		for c in input_line:
			if(c != "."):
				var val = int(c)
				if(val == 0 && c != "0"):
					symbol_map[coord(x,y)] = c
			x+= 1;
		y += 1
	
	# Loop through parts, and evaluate adjacent pairs
	for c in symbol_map.keys():
		#output += "Checking %s at %s\n" % [symbol_map[c], c]
		for part in parts_list:
			#output += "  %s overlaps %s\n" % [c, str(part)]
			if(part.overlap_hit(c)):
				total += part.number
	
	for part in parts_list:
		if(!part.counted):
			output += "%s\n" % [part]
	
	output += "Total = " + str(total)
	
	return output


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
	
	# Process Map
	var y = 0;
	for input_line in input.split("\n"):
		var x = 0
		var cur_num = ""
		var num_started = false
		var num_ended = false
		
		# stupid hack to deal with numbers that end on the last char. Will replace later once I know more about part2
		input_line = input_line + "."
		
		for c in input_line:
			if(c == "."):
				num_ended = (num_started == true)
			else:
				var val = int(c)
				if(val == 0 && c != "0"):
					symbol_map[coord(x,y)] = c
					num_ended = true
				else:
					num_started = true #even if already started
					cur_num = cur_num + c
				#output += "Found [%s] at %d,%d.  Value is %d\n" % [c, x, y, int(c)]
			
			if(num_ended == true && cur_num != ""):
				var new_part = ToolPart.new(cur_num, x-1, y)
				parts_list.append(new_part)
				cur_num = ""
				num_ended = false
				num_started = false
			
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


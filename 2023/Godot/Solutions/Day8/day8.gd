extends Day

class_name Day8

var travel_map = null

func _find_or_create_node(name):
	if(!travel_map.has(name)):
		travel_map[name] = TravelNode.new(name)
	
	return travel_map[name]

func part_1(input):
	var total = 0;
	var output = ""
	var directions = null
	
	travel_map = {}
		
	#RLLLLR
	var dirRegex = RegEx.new();
	dirRegex.compile("^([RL]+)$")
	
	#AAA = (BBB, CCC)
	var mapRegex = RegEx.new();
	mapRegex.compile("([A-Z]+) = \\(([A-Z]+), ([A-Z]+)\\)")
	
	for input_line in input.split("\n"):		
		var mapResult = mapRegex.search(input_line)
		if(mapResult):
			#output += "Node map <%s> <%s> <%s>\n" % [mapResult.get_string(1),mapResult.get_string(2),mapResult.get_string(3)]
			var parent = _find_or_create_node(mapResult.get_string(1))
			var left = _find_or_create_node(mapResult.get_string(2))
			var right = _find_or_create_node(mapResult.get_string(3))
			parent.connect_to(left, right)
		
		var dirResult = dirRegex.search(input_line)
		if(dirResult):
			output += "directions: [%s]\n" % [dirResult.get_string(1)]
			directions = dirResult.get_string(1)
			continue
	
	
	# Navigate
	var cur_node = _find_or_create_node("AAA")
	var foundExit = false
	for i in 1000000: #depth limit on endless navigation
		if(cur_node == null):
			output += "I got lost!\n"
			break
		
		var direction = directions[i % directions.length()]
		cur_node = cur_node.node_for_direction(direction)
		#output += "%d: Going %s to %s\n" % [i, direction, cur_node.location]
		#print("%d: Going %s to %s" % [i, direction, cur_node.location])
		
		if(i % 100 == 0):
			progress_updated.emit(float(i%directions.length())/directions.length())
			output_updated.emit(output)
			await get_tree().process_frame
		
		if(cur_node.location == "ZZZ"):
			total = i + 1
			foundExit = true
			break
	
	output += "Steps taken = " + str(total)	
	finish(output)


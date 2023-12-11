extends Day

class_name Day5

func part_1(input):
	var total = 0;
	var output = ""
	var mappers = {}
	
	#seeds: 79 14 55 13
	var seedsRegex = RegEx.new()
	seedsRegex.compile("^seeds: ([\\d ]+)")
	
	#seed-to-soil map:	
	var mapRegex = RegEx.new()
	mapRegex.compile("^([a-z]+)-to-([a-z]+) map:")
	
	#50 98 2
	var dataRegex = RegEx.new()
	dataRegex.compile("(\\d+) (\\d+) (\\d+)")
	
	var cur_mapper_key = null
	var items = []
	
	# Read Almanac - Build Maps
	for input_line in input.split("\n"):		
		var seedResult = seedsRegex.search(input_line)
		if(seedResult):			
			items = seedResult.get_string(1).strip_edges().split_floats(" ")
			output += "Seeds found %s\n" % [items]			
			continue
		
		var mapResult = mapRegex.search(input_line)
		if(mapResult):
			cur_mapper_key = "%s-%s" % [mapResult.get_string(1), mapResult.get_string(2)]
			mappers[cur_mapper_key] = []
			continue
		
		var dataResult = dataRegex.search(input_line)
		if(dataResult):
			var mapper = Mapper.new(int(dataResult.get_string(2)), int(dataResult.get_string(1)), int(dataResult.get_string(3)))
			mappers[cur_mapper_key].append(mapper)
			#output += "mapping %s\n" % [mapper]
		
	# Figure out soils
	
	#these are sorted in order (for now) so we'll just run through them one by one	
	for k in mappers.keys():
		var new_items = []
		var mappers_list = mappers[k]
		
		for item in items:
			var found = false
			
			for mapper in mappers_list:
				if(mapper.contains(item)):
					new_items.append(mapper.map(item))
					found = true
					break

			if(!found):
				new_items.append(item)
		
		items = new_items;
		output += "New Items %s\n" % [" ".join(items)]
	
	output += "Min = " + str(items.min())	
	finish(output)

func part_2(input):
	#This implementation is very bad, i was just using it as a test case for my progress bar
	#TODO actually come up with a real solution
	print("Started")
	var total = 0;
	var output = ""
	var mappers = {}
	
	#seeds: 79 14 55 13
	var seedsRegex = RegEx.new()
	seedsRegex.compile("^seeds: ([\\d ]+)")
	
	#seed-to-soil map:	
	var mapRegex = RegEx.new()
	mapRegex.compile("^([a-z]+)-to-([a-z]+) map:")
	
	#50 98 2
	var dataRegex = RegEx.new()
	dataRegex.compile("(\\d+) (\\d+) (\\d+)")
	
	var cur_mapper_key = null
	var items = []
	
	# Read Almanac - Build Maps
	for input_line in input.split("\n"):		
		var seedResult = seedsRegex.search(input_line)
		if(seedResult):			
			items = seedResult.get_string(1).strip_edges().split_floats(" ")
			output += "Seeds found %s\n" % [items]			
			continue
		
		var mapResult = mapRegex.search(input_line)
		if(mapResult):
			cur_mapper_key = "%s-%s" % [mapResult.get_string(1), mapResult.get_string(2)]
			mappers[cur_mapper_key] = []
			continue
		
		var dataResult = dataRegex.search(input_line)
		if(dataResult):
			var mapper = Mapper.new(int(dataResult.get_string(2)), int(dataResult.get_string(1)), int(dataResult.get_string(3)))
			mappers[cur_mapper_key].append(mapper)
			#output += "mapping %s\n" % [mapper]
	
	#expand seeds
	var new_seeds = []
	for i in items.size()/2:
		for j in items[i*2 + 1]:
			new_seeds.append(items[i*2]+j)
	items = new_seeds	
	
	output += "Evaluating seeds: %s\n" % [items]
	
	# Figure out soils
	
	var layers = mappers.keys().size()
	var seed_length = items.size()
	var total_length = layers * seed_length
	
	#these are sorted in order (for now) so we'll just run through them one by one	
	var counter = 0
	for k in mappers.keys():
		var new_items = []
		var mappers_list = mappers[k]
		
		for item in items:
			var found = false
			
			for mapper in mappers_list:
				if(mapper.contains(item)):
					new_items.append(mapper.map(item))
					found = true
					break
			
			if(!found):
				new_items.append(item)
			
			counter += 1
			
			if(counter % 1000 == 0):
				var progress = float(counter) / total_length
				progress_updated.emit(progress)
				#await get_tree().process_frame
		
		items = new_items;
		output += "New Items %s\n" % [" ".join(items)]
	
	output += "Min = " + str(items.min())
	
	print("finished")
	
	finish(output)

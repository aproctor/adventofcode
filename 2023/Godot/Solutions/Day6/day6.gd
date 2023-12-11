extends Day

class_name Day6

func part_1(input):
	var product = 1;
	var output = ""
	
	#Time:      7  15   30
	#Distance:  9  40  200
	var timeRegex = RegEx.new()
	timeRegex.compile("Time: +([\\d ]+)")
	
	var distRegex = RegEx.new()
	distRegex.compile("Distance: +([\\d ]+)")
	
	var times = null
	var distances = null
	
	# Read Almanac - Build Maps
	for input_line in input.split("\n"):		
		var timeResult = timeRegex.search(input_line)
		if(timeResult):
			times = timeResult.get_string(1).split_floats(" ", false)
			continue
		
		var distResult = distRegex.search(input_line)
		if(distResult):
			distances = distResult.get_string(1).split_floats(" ", false)
	
	# Formula y = Tx - x^2
	# y = ax^2 + bx + c
	# a = -1
	# b = total time
	# c = 0
	# Max = c - b^2 / 4a
	# Max = b^2 / 4
	
	var index = 0
	for time in times:
		var max = (time * time) / 4
		var record = distances[index] #assumes that distances and times are the same length
		output += "Maximum for %d is %d\n" % [time, max]
		
		var winning_ways = 0
		for i in time:
			var t = i
			var dist = time*t - (t*t)
			
			if(dist > record):
				winning_ways += 1
				output += "%d > %d after holding for %d\n" % [dist, record, t]#			
		
		if(winning_ways > 0):
			product = product * winning_ways
		
		index += 1
		
	output += "Part 1: %d\n" % [product]	
	finish(output)

func part_2(input):
	var product = 1;
	var output = "Part 2\n"
	
	#Time:      7  15   30
	#Distance:  9  40  200
	var timeRegex = RegEx.new()
	timeRegex.compile("Time: +([\\d ]+)")
	
	var distRegex = RegEx.new()
	distRegex.compile("Distance: +([\\d ]+)")
	
	var time = 0
	var dist = 0
	var distance_string = ""
	
	# Read Almanac - Build Maps
	for input_line in input.split("\n"):		
		var timeResult = timeRegex.search(input_line)
		if(timeResult):			
			var time_string = ""
			for t in timeResult.get_string(1).split_floats(" ", false):
				time_string += str(t)
			time = int(time_string)
			continue
		
		var distResult = distRegex.search(input_line)
		if(distResult):
			var d_string = ""
			for d in distResult.get_string(1).split_floats(" ", false):
				d_string += str(d)			
			dist = int(d_string)
		
	output += "part 2 evaluating the max for: %d and %d\n" % [time, dist]
	
	# Formula y = Tx - x^2
	# y = ax^2 + bx + c
	# a = -1
	# b = total time
	# c = 0
	#
	# Move Down by the record distance and see where y = 0
	# c = -dist
	# x = (-b +/- sqrt(b^2 - 4ac)) / 2a
	# x = (T +/- sqrt(T^2 - 4*dist))/2
	
	var delta = sqrt(time*time - 4*dist)
	var x1 = ceil((time - delta) / 2)
	var x2 = floor((time + delta) / 2)
	output += "Min Bound: %d\nMax Bound %d\n" % [x1, x2]
	var y = time * x1 - (x1 * x1)
	#output += "f(%d) = %f\n" % [x1, y]
		
	var winning_ways = x2 - x1 + 1
	
	output += "Part 2: %d\n" % [winning_ways]	
	finish(output)

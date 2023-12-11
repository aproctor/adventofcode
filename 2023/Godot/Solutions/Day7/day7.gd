extends Day

class_name Day7

func part_1(input) -> String:
	var output = ""
	
	
	#32T3K 765
	var handRegex = RegEx.new()
	handRegex.compile("([AKQJT2-9]+) ([\\d]+)")
	
	var hands = []

	# Read Almanac - Build Maps
	for input_line in input.split("\n"):
		var result = handRegex.search(input_line)
		if(result):
			#output += "Building hand [%s] [%s]\n" % [result.get_string(1), result.get_string(2)]
			hands.append(Hand.new(result.get_string(1), int(result.get_string(2))))
	
	hands.sort_custom(func(a, b): return a.compare_to(b) > 0)
	
	var total = 0
	for i in hands.size():
		var h = hands[i]
		var r = hands.size() - i
		var score = h.bid * r
		output += "%d: %s has a score of %d\n" % [r, h, score]
		total += score
	
	output += "Total: %d\n" % [total]
	
	return output

extends Day

class_name Day4

func part_1(input) -> String:
	var total = 0;
	var output = ""
		
	var cardRegex = RegEx.new();
	cardRegex.compile("Card +(\\d+): ([0-9 ]+) \\| ([0-9 ]+)")
	
	for input_line in input.split("\n"):		
		var result = cardRegex.search(input_line)
		if(result):
			#output += "%s: [%s][%s]\n" % [result.get_string(1), result.get_string(2), result.get_string(3)]
			var card_id = result.get_string(1)
			var winning_numbers = result.get_string(2).strip_edges().split_floats(" ")
			var card_numbers = result.get_string(3).strip_edges().split_floats(" ")
			var card_score = 0
			var matches = {}
			
			#output += "%s vs %s\n" % [winning_numbers, card_numbers]
			
			for winner in winning_numbers:
				for num in card_numbers:
					if(num == winner && int(num) != 0 && !matches.has(num)):
						#output += "\tWINNER! [%s][%s]\n" % [num, winner]
						matches[num] = true
						if(card_score == 0):
							card_score = 1
						else:
							card_score = card_score * 2
							
			total += card_score
			
			output += "Card %s scores %d.  Matching %s\n" % [card_id, card_score, ",".join(matches.keys())]
	
	output += "Total = " + str(total)
	
	return output

func part_2(input) -> String:
	var total = 0;
	var output = ""
		
	var cardRegex = RegEx.new();
	cardRegex.compile("Card +(\\d+): ([0-9 ]+) \\| ([0-9 ]+)")
	
	var card_scores = {};
	var current_cards = []
	
	# Analyze card values
	for input_line in input.split("\n"):		
		var result = cardRegex.search(input_line)
		if(result):
			#output += "%s: [%s][%s]\n" % [result.get_string(1), result.get_string(2), result.get_string(3)]
			var card_id = int(result.get_string(1))
			var winning_numbers = result.get_string(2).strip_edges().split_floats(" ")
			var card_numbers = result.get_string(3).strip_edges().split_floats(" ")
			var card_score = 0
			var matches = {}
			
			#output += "%s vs %s\n" % [winning_numbers, card_numbers]
			
			for winner in winning_numbers:
				for num in card_numbers:
					if(num == winner && int(num) != 0 && !matches.has(num)):
						#output += "\tWINNER! [%s][%s]\n" % [num, winner]
						matches[num] = true
						card_score += 1
			if(card_score > 0):
				card_scores[card_id] = card_score
			current_cards.append(card_id)
			
			# count all original cards as we're only counting winner values from now on
			total += 1
			
			#output += "Card %s scores %d.  Matching %s\n" % [card_id, card_score, ",".join(matches.keys())]
	
	for limit_count in 100000: #limited to prevent infinite loops
		if(current_cards.size() == 0):
			break
			
		output += str(limit_count) + ": "+",".join(current_cards) + "\n"
		
		var new_cards = []
		for c in current_cards:				
			if card_scores.has(c):
				#output += "%d scores %d\n" % [c, card_scores[c]]
				total += card_scores[c]				
				for i in card_scores[c]:
					new_cards.append(c + i + 1)
		current_cards = new_cards
	
	output += "Total = " + str(total)
	
	return output


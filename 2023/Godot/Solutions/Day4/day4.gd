extends Day

class_name Day4

func part_1(input) -> String:
	var total = 0;
	var output = ""
	
	var targets = {
		"red": 12,
		"green": 13,
		"blue": 14
	};
		
	var cardRegex = RegEx.new();
	cardRegex.compile("Card +(\\d+): ([0-9 ]+) \\| ([0-9 ]+)")
	
	var games = {};
	
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


extends Day

class_name Day2

func part_1(input):
	var total = 0;
	var output = ""
	
	var targets = {
		"red": 12,
		"green": 13,
		"blue": 14
	};
		
	var gameRegex = RegEx.new();
	gameRegex.compile("Game (\\d+): (.*)")
	
	var games = {};
	
	for input_line in input.split("\n"):		
		var result = gameRegex.search(input_line)
		if(result):
			#Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
			#output += "%s: [%s]\n" % [result.get_string(1), result.get_string(2)]
			var game_id = result.get_string(1)
			var rounds = result.get_string(2).split("; ")			
			var valid = true;
			
			for round in rounds:
				for pull in round.split(", "):
					var p = pull.split(" ");
					if(targets[p[1]] < int(p[0])):
						valid = false;
				
			if(valid):
				output += "Game %s is valid!\n" % [game_id]
				total += int(game_id)
	
	output += "Total = " + str(total)
	
	finish(output)

func part_2(input):
	var total = 0
	var output = ""
	
			
	var gameRegex = RegEx.new();
	gameRegex.compile("Game (\\d+): (.*)")
	
	var games = {};
	
	for input_line in input.split("\n"):		
		var result = gameRegex.search(input_line)
		if(result):
			#Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
			#output += "%s: [%s]\n" % [result.get_string(1), result.get_string(2)]
			var game_id = result.get_string(1)
			var rounds = result.get_string(2).split("; ")			
			
			var counts = {
				"red": 0,
				"green": 0,
				"blue": 0
			};
			
			for round in rounds:
				for pull in round.split(", "):
					var p = pull.split(" ");					
					
					if(counts[p[1]] < int(p[0])):
						counts[p[1]] = int(p[0])
			
			var product = counts["red"] * counts["green"] * counts["blue"]
			output += "%s: %d * %d * %d = %d\n" % [game_id, counts["red"], counts["green"], counts["blue"], product]
			
			total += product
	
	output += "Total = " + str(total)
	
	finish(output)

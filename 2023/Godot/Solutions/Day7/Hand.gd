extends Object

class_name Hand

@export var bid : int = 0
@export var cards = ""
var _stored_rank = null
var using_jokers = false

var card_value_map = {
	"A": 14,
	"K": 13,
	"Q": 12,
	"J": 11,
	"T": 10,
	"9": 9,
	"8": 8,
	"7": 7,
	"6": 6,
	"5": 5,
	"4": 4,
	"3": 3,
	"2": 2,
}

func _init(hand, bid_size, jokers):
	cards = hand
	bid = bid_size
	
	if(jokers):
		use_jokers()
	
func use_jokers():
	#This is not reversible, but i'm fine with that
	card_value_map["J"] = 1
	using_jokers = true
	
func hand_rank() -> int:		
	if(_stored_rank != null):
		return _stored_rank
	
	var rank = 0
	var seen_cards = {}

	#Analyze unique cards
	var max_count = 0
	var max_key = null
	for c in cards:
		var count = 1
		if(seen_cards.has(c)):
			count = seen_cards[c] + 1
		seen_cards[c] = count
		
		if(count > max_count):
			max_count = count
			max_key = c
	
	#build poker hands
	
	if(max_count == 5):
		#Five of a kind, where all five cards have the same label: AAAAA
		rank = 7
	elif(max_count == 4):
		#Four of a kind, where four cards have the same label and one card has a different label: AA8AA
		rank = 6
	elif(max_count == 3):
		if(seen_cards.keys().size() == 2):
			#Full house, where three cards have the same label, and the remaining two cards share a different label: 23332		
			rank = 5
		else:
			#Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
			rank = 4
	elif (max_count == 2):
		if(seen_cards.keys().size() == 3):
			#Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
			rank = 3
		else:
			#One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
			rank = 2
	else:
		#High card, where all cards' labels are distinct: 23456
		rank = 1
	
	#memoize results for future lookup
	_stored_rank = rank	
	return rank

# Similar to hand rank, but we have to make it pretty messy for joker suport
func hand_rank_with_jokers() -> int:
	if(_stored_rank != null):
		return _stored_rank
	
	var rank = 0
	var seen_cards = {}

	#Analyze unique cards
	var max_count = 0
	var max_key = null
	var joker_count = 0
	for c in cards:
		if c == "J":
			joker_count += 1
			continue
			
		var count = 1
		if(seen_cards.has(c)):
			count = seen_cards[c] + 1
		seen_cards[c] = count
		
		if(count > max_count):
			max_count = count
			max_key = c
	
	if(max_count == 0):
		#Edge case for all jokers, assume we'll be dealing out aces
		var key = "A"
		max_key = key
		seen_cards[key] = 0
	elif(max_count == 1):
		#Edge case for 1 of a kind, let's determine the best card by card rank
		var best_card_val = 0
		for c2 in cards:
			var card_rank = card_value_map[c2]
			if(card_rank > best_card_val):
				best_card_val = card_rank
				max_key = c2
	
	#Transform hand based on jokers
	for i in joker_count:
		seen_cards[max_key] = seen_cards[max_key] + 1
		max_count += 1
	
	#build poker hands	
	if(max_count == 5):
		#Five of a kind, where all five cards have the same label: AAAAA
		rank = 7
	elif(max_count == 4):
		#Four of a kind, where four cards have the same label and one card has a different label: AA8AA
		rank = 6
	elif(max_count == 3):
		if(seen_cards.keys().size() == 2):
			#Full house, where three cards have the same label, and the remaining two cards share a different label: 23332		
			rank = 5
		else:
			#Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
			rank = 4
	elif (max_count == 2):
		if(seen_cards.keys().size() == 3):
			#Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
			rank = 3
		else:
			#One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
			rank = 2
	else:
		#High card, where all cards' labels are distinct: 23456
		rank = 1
	
	#memoize results for future lookup
	_stored_rank = rank	
	return rank

#Comparator for part 1
func compare_to(other) -> int:
	var hand_comp = 0
	if(using_jokers):
		hand_comp = hand_rank_with_jokers() - other.hand_rank_with_jokers()
	else:
		hand_comp = hand_rank() - other.hand_rank()
	
	if(hand_comp != 0):
		return hand_comp
	
	#Hands are the same value, compare cards in order
	for i in cards.length():
		var card_comp = card_value_map[cards[i]] - card_value_map[other.cards[i]]
		if(card_comp != 0):
			return card_comp
		
	#Hands are identical
	return 0


func _to_string():
	return "Hand [%s]" % [cards]

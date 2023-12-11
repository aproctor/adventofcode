extends Object

class_name Hand

@export var bid : int = 0
@export var cards = ""
var _stored_rank = null

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

func _init(hand, bid_size):
	cards = hand
	bid = bid_size
	
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

func compare_to(other) -> int:
	var hand_comp = hand_rank() - other.hand_rank()
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

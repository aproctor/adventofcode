extends Object

class_name Pipe

@export var x : int = 0
@export var y : int = 0
@export var used : bool = false
@export var shape : String
var attachments : Array[Pipe]

enum Directions {UP, RIGHT, DOWN, LEFT}

var sprite_map = {
	"7": 0,
	"F": 1,
	"-": 2,
	"J": 3,
	"L": 4,
	"|": 5,
	"S": 0
}

func _init(_x, _y, _shape):
	x = _x
	y = _y
	shape = _shape
	attachments = []

func attach_to(other : Pipe):
	attachments.append(other)
	
# returns the value of the sprite
func sprite_index() -> int:
	var index = sprite_map[shape]	
	
	if(used):
		index += 6
	return index

func opens_up() -> bool:	
	return (shape == "S" || shape == "|" || shape == "J" || shape == "L")

func opens_down() -> bool:
	return (shape == "S" || shape == "|" || shape == "F" || shape == "7")

func opens_left() -> bool:
	return (shape == "S" || shape == "-" || shape == "J" || shape == "7")

func opens_right() -> bool:
	return (shape == "S" || shape == "-" || shape == "L" || shape == "F")

func connects_with(other, dir):
	if(dir == Directions.UP):
		return (opens_up() && other.opens_down());
	elif(dir == Directions.RIGHT):
		return (opens_right() && other.opens_left());
	elif(dir == Directions.DOWN):
		return (opens_down() && other.opens_up());
	elif(dir == Directions.LEFT):
		return (opens_left() && other.opens_right());
	return false

# Returns Up, Right, Down, Left
func adjacent_coords() -> Array:
	var results = [
		"%d,%d" % [x, y-1], #UP
		"%d,%d" % [x+1, y], #RIGHT
		"%d,%d" % [x, y+1], #DOWN
		"%d,%d" % [x-1, y], #LEFT
	]
	return results


extends Object

class_name TravelNode

@export var location = ""
var left_node : TravelNode = null
var right_node : TravelNode = null
@export var start_node : bool = false
@export var end_node : bool = false

func _init(loc):
	location = loc
	start_node = (loc[-1] == "A")
	end_node = (loc[-1] == "Z")

func connect_to(left, right):
	left_node = left
	right_node = right
	
func node_for_direction(dir):
	if(dir == "L"):
		return left_node
	if(dir == "R"):
		return right_node
	return null #can't find a node

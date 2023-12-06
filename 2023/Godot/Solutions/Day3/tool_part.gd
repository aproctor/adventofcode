extends RefCounted

class_name ToolPart

@export var number : int = 0
var start_x : int = 0
var y : int = 0
var end_x : int = 0

@export var counted : bool

func _init(number_string, x_val, y_val):
	number = int(number_string)
	start_x = x_val
	y = y_val
	end_x = x_val + number_string.length() - 1
	counted = false

func overlap_hit(coord) -> bool:	
	var hit = counted == false && overlaps(coord)
	if(hit):		
		counted = true
	return hit

func overlaps(coord) -> bool:
	var vals = coord.split(",")
	var sym_x = int(vals[0])
	var sym_y = int(vals[1])
	return (sym_x >= start_x - 1 && sym_x <= end_x + 1 && sym_y >= y-1 && sym_y <= y+1)

func _to_string():
	return "Part %d at %d,%d %s" % [number, start_x, y, str(counted)]

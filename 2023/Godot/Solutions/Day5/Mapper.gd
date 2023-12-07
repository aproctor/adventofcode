extends Object

class_name Mapper

var source_start : int = 0
var dest_start : int = 0
var range : int = 0

func _init(s, d, r):
	source_start = s
	dest_start = d
	range = r
	
func contains(item) -> bool:
	return (item >= source_start && item < source_start + range)
	
func map(item) -> int:
	return (dest_start + (item - source_start))
	
func _to_string():
	return "source[%d-%d] to dest[%d-%d]" % [source_start, source_start+range,dest_start, dest_start + range]
	

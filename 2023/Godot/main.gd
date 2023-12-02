extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_day_1_pressed():
	set_day(1)
	
func _on_day_2_pressed():
	set_day(2)

func set_day(num):
	get_node("DebugText").text = "Day %d" % [num]

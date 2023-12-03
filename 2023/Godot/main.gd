extends Control

var input_file = '';

var input_text_area_object = null;
var output_text_area_object = null;

var input_options_object = null;
var day_label_object = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	input_options_object = get_node("DayDetails/TopBar/InputOptions")
	day_label_object = get_node("DayDetails/TopBar/DayLabel")
	input_text_area_object = get_node("DayDetails/InputText")
	output_text_area_object = get_node("DayDetails/OutputText")

func _on_day_1_pressed():
	set_day(1, ["res://Day1/day1_sample.txt", "res://Day1/day1_data.txt"])
	
func _on_day_2_pressed():
	set_day(2, [])

func set_day(num, options):
	input_text_area_object.text = ""
	output_text_area_object.text = ""
	
	day_label_object.text = "Day %d" % [num]
		
	input_options_object.clear()
	if(options.size() > 0):
		for opt in options:
			input_options_object.add_item(opt)
		_on_input_options_item_selected(0)

func _on_input_options_item_selected(index):		
	if(index >= 0):
		input_text_area_object.text = FileAccess.get_file_as_string(input_options_object.get_item_text(index));

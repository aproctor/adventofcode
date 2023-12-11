extends Control

var input_file = '';

var input_text_area_object = null;
var output_text_area_object = null;
var progress_bar_object = null;

var input_options_object = null;
var day_label_object = null;
var current_day = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	#Maybe change these to exported node properties and map them in inspector?
	input_options_object = get_node("DayDetails/TopBar/InputOptions")
	day_label_object = get_node("DayDetails/TopBar/DayLabel")
	input_text_area_object = get_node("DayDetails/InputText")
	output_text_area_object = get_node("DayDetails/OutputText")
	progress_bar_object = get_node("DayDetails/ProgressBar")


func set_day(num):	
	var day_node : Day = get_node("Days/Day%d" % [num])
	current_day = day_node
	
	input_text_area_object.text = ""
	output_text_area_object.text = ""
	current_day.output_updated.connect(_update_output)

	_update_progress(0)	
	current_day.progress_updated.connect(_update_progress)	
	
	day_label_object.text = "Day %d" % [num]
		
	input_options_object.clear()
	if(day_node != null && day_node.input_files.size() > 0):
		for opt in day_node.input_files:
			input_options_object.add_item(opt)
		_on_input_options_item_selected(0)

func _on_input_options_item_selected(index):		
	if(index >= 0):
		input_text_area_object.text = FileAccess.get_file_as_string(input_options_object.get_item_text(index));

func _on_run_part_1_pressed():
	if(current_day != null):
		_update_progress(0)		
		current_day.part_1(input_text_area_object.text)

func _on_run_part_2_pressed():
	if(current_day != null):
		_update_progress(0)
		current_day.part_2(input_text_area_object.text)

func _on_day_button_1_pressed():
	set_day(1)


func _on_day_button_2_pressed():
	set_day(2)


func _on_day_button_3_pressed():
	set_day(3)


func _on_day_button_4_pressed():
	set_day(4)


func _on_day_button_5_pressed():
	set_day(5)


func _on_day_button_6_pressed():
	set_day(6)


func _on_day_button_7_pressed():
	set_day(7)


func _on_day_button_8_pressed():
	set_day(8)


func _on_day_button_9_pressed():
	set_day(9)


func _on_day_button_10_pressed():
	set_day(10)


func _on_day_button_11_pressed():
	set_day(11)


func _on_day_button_12_pressed():
	set_day(12)


func _on_day_button_13_pressed():
	set_day(13)


func _on_day_button_14_pressed():
	set_day(14)


func _on_day_button_15_pressed():
	set_day(15)


func _on_day_button_16_pressed():
	set_day(16)


func _on_day_button_17_pressed():
	set_day(17)


func _on_day_button_18_pressed():
	set_day(18)


func _on_day_button_19_pressed():
	set_day(19)


func _on_day_button_20_pressed():
	set_day(20)


func _on_day_button_21_pressed():
	set_day(21)


func _on_day_button_22_pressed():
	set_day(22)


func _on_day_button_23_pressed():
	set_day(23)


func _on_day_button_24_pressed():
	set_day(24)


func _on_day_button_25_pressed():
	set_day(25)

func _update_progress(val):
	progress_bar_object.value = val

func _update_output(out):
	output_text_area_object.text = out

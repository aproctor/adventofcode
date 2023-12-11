extends Node

class_name Day

@export var input_files : Array[String] = [];

signal progress_updated(pct)
signal output_updated(output)

func part_1(input):
	finish("Part 1: Not Implemented")

func part_2(output):
	finish("Part 2: Not Implemented")

func finish(output):
	output_updated.emit(output)
	progress_updated.emit(1)

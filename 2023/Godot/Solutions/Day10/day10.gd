extends Day

class_name Day10

@export var mainWindow : Window = null
@export var pipeCanvas : Node = null
@export var pipeSprites : Array[Resource] = []
@export var outsideTile : PackedScene
@export var insideTile : PackedScene

const SPRITE_SIZE = 32

func _ready():
	mainWindow.close_requested.connect(_on_close_window)
	

func scale_canvas(rows:float, cols:float):
	# Canvas is roughly 21x32 grids wide and 15x32 grids tall
	var targetScaler = max(rows/15, cols/21, 1)
	pipeCanvas.scale = Vector2(1 / targetScaler, 1 / targetScaler)

func part_1(input):
	var total = 0;
	var output = ""
	var pipes = {}
	
	var dataRegex = RegEx.new()
	dataRegex.compile("^([|\\-LJ7F\\.S]+)$")
	
	mainWindow.show()
		
	var x = 0
	var y = 0
	
	#Clear existing Pipes
	for c in pipeCanvas.get_children():
		pipeCanvas.remove_child(c)
		c.queue_free()
	
	#Spawn new pipes
	var start_pipe = null
	for input_line in input.split("\n"):
		var matchResult = dataRegex.search(input_line)
		if(matchResult):
			x = 0
			for c in input_line:
				if(c != "."):
					var coord = "%d,%d" % [x, y]
					var pipe = Pipe.new(x, y, c)
					pipes[coord] = pipe
					
					if(c == "S"):
						start_pipe = pipe
						pipe.used = true
					else:
						update_sprite(pipe)

				x += 1
		y += 1

	fix_start_pipe(start_pipe, pipes)
	scale_canvas(x/2.0, y/2.0)
	
	#Traverse the pipes
	var active_pipes = [start_pipe]
	for i in 10000:
		var unvisited_neghbours = []
		for cur_pipe in active_pipes:
			cur_pipe.used = true
			update_sprite(cur_pipe)
			
			var connections = pipe_connections(cur_pipe, pipes)	
			for p in connections:
				if(p != null && !p.used):
					unvisited_neghbours.append(p)
		
		active_pipes = unvisited_neghbours
		if(active_pipes.size() == 0):
			break
		#await get_tree().create_timer(0.1).timeout
		await get_tree().process_frame	
		total += 1
	
	output += "Total = " + str(total)
	
	finish(output)

func part_2(input):
	var total = 0;
	var output = ""
	var pipes = {}
	
	var dataRegex = RegEx.new()
	dataRegex.compile("^([|\\-LJ7F\\.S]+)$")
	
	mainWindow.show()
		
	var x = 0
	var y = 0
	
	#Clear existing Pipes
	for c in pipeCanvas.get_children():
		pipeCanvas.remove_child(c)
		c.queue_free()
	
	#Spawn new pipes
	var start_pipe = null
	for input_line in input.split("\n"):
		var matchResult = dataRegex.search(input_line)
		if(matchResult):
			x = 0
			for c in input_line:
				if(c != "."):
					var coord = "%d,%d" % [x, y]
					var pipe = Pipe.new(x, y, c)
					pipes[coord] = pipe
					
					if(c == "S"):
						start_pipe = pipe
						pipe.used = true
					else:
						update_sprite(pipe)

				x += 1
		y += 1

	fix_start_pipe(start_pipe, pipes)
	scale_canvas(x/2.0, y/2.0)
	
	#Traverse the pipes
	var active_pipes = [start_pipe]
	for i in 10000:
		var unvisited_neghbours = []
		for cur_pipe in active_pipes:
			cur_pipe.used = true
			update_sprite(cur_pipe)
			
			var connections = pipe_connections(cur_pipe, pipes)	
			for p in connections:
				if(p != null && !p.used):
					unvisited_neghbours.append(p)
		
		active_pipes = unvisited_neghbours
		if(active_pipes.size() == 0):
			break
		#await get_tree().create_timer(0.1).timeout
		#await get_tree().process_frame	
	
	var tile_sprite = null
	for y2 in y:
		var crossed_lines = 0
		for x2 in x:
			var coord = "%d,%d" % [x2, y2]
			if(pipes.has(coord)):
				var pipe = pipes[coord]
				if(pipe.used):
					crossed_lines += 1
					continue
			
			if((crossed_lines) % 2 == 0):
				tile_sprite = outsideTile.instantiate()
			else:
				tile_sprite = insideTile.instantiate()
			pipeCanvas.add_child(tile_sprite)
			tile_sprite.position = Vector2(SPRITE_SIZE*x2, SPRITE_SIZE*y2)
	
	
	
	output += "Total = " + str(total)
	
	finish(output)

func update_sprite(pipe):
	var pipe_sprite = pipeSprites[pipe.sprite_index()].instantiate()
	#todo kill existing?
	pipeCanvas.add_child(pipe_sprite)
	pipe_sprite.position = Vector2(SPRITE_SIZE*pipe.x, SPRITE_SIZE*pipe.y)
	
func pipe_connections(pipe, pipes):
	var up_pipe = null
	var down_pipe = null
	var right_pipe = null	
	var left_pipe = null
	
	var neighbours = pipe.adjacent_coords()
	
	# Check Up Pipe
	if(pipes.has(neighbours[Pipe.Directions.UP])):
		up_pipe = pipes[neighbours[Pipe.Directions.UP]]
		if(!pipe.connects_with(up_pipe, Pipe.Directions.UP)):
			up_pipe = null
			
	# Check Right Pipe
	if(pipes.has(neighbours[Pipe.Directions.RIGHT])):
		right_pipe = pipes[neighbours[Pipe.Directions.RIGHT]]
		if(!pipe.connects_with(right_pipe, Pipe.Directions.RIGHT)):
			right_pipe = null
	
	# Check Down Pipe
	if(pipes.has(neighbours[Pipe.Directions.DOWN])):
		down_pipe = pipes[neighbours[Pipe.Directions.DOWN]]
		if(!pipe.connects_with(down_pipe, Pipe.Directions.DOWN)):
			down_pipe = null
	
	# Check Left Pipe
	if(pipes.has(neighbours[Pipe.Directions.LEFT])):
		left_pipe = pipes[neighbours[Pipe.Directions.LEFT]]
		if(!pipe.connects_with(left_pipe, Pipe.Directions.LEFT)):
			left_pipe = null
	
	
	return [up_pipe, right_pipe, down_pipe, left_pipe]
	

func fix_start_pipe(start_pipe, pipes):
	if(start_pipe == null):
		return
	
	var connections = pipe_connections(start_pipe, pipes)
	var connects_up = connections[0] != null
	var connects_right = connections[1] != null
	var connects_down = connections[2] != null
	var connects_left = connections[3] != null
	
	var symbol = "S"
	if(connects_left && connects_down):
		symbol = "7"
	elif(connects_right && connects_down):
		symbol = "F"
	elif(connects_right && connects_left):
		symbol = "-"
	elif(connects_left && connects_up):
		symbol = "J"
	elif(connects_right && connects_up):
		symbol = "L"
	elif(connects_up && connects_down):
		symbol = "|"
	
	start_pipe.shape = symbol
	
	update_sprite(start_pipe)

func _on_close_window():
	mainWindow.hide()

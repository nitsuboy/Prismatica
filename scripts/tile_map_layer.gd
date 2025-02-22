extends TileMapLayer

var camera

var levels = [
	[
		#level 1
		[1,1,1,1,1,1,1,1,1],
		[1,0,5,0,0,0,10,0,1],
		[1,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,0,0,1],
		[1,0,9,0,0,0,8,0,1],
		[1,1,1,1,1,1,1,1,1]
	],
	[#level 2
		[0,1,0,1,0,1,0,1,0],
		[1,0,1,0,1,0,1,0,1],
		[0,1,0,1,0,1,0,1,0],
		[1,0,1,0,1,0,1,0,1],
		[3,3,3,3,3,3,3,3,3],
		[1,0,1,0,1,0,1,0,1],
		[0,1,0,1,0,1,0,1,0],
		[1,0,1,0,1,0,1,0,1],
		[0,1,0,1,0,1,0,1,0]
	]
]

var current_level = 0
var tile_size = 32

var wall:PackedScene = preload("res://scenes/wall.tscn")
var mirror:PackedScene = preload("res://scenes/mirror.tscn")
var emissor:PackedScene = preload("res://scenes/emissor.tscn")
var reciver:PackedScene = preload("res://scenes/reciver.tscn")
#var divider = preload("scenes")

const MAX_BOARD_SIZE = 30

func load_level(level_index: int):
	for c in get_children():
		c.queue_free()
	
	var board = levels[level_index]
	var width = board[0].size()
	var height = board.size()
	
	if abs(width - height) > max(width, height) * 0.5:
		print("Invalid board size. Difference > 50%")
		return
	
	if width > MAX_BOARD_SIZE or height > MAX_BOARD_SIZE:
		print("Invalid board size")
		return

	for y in range(height):
		for x in range(width):
			match board[y][x]:
				1:
					var ins = wall.instantiate()
					ins.position = Vector2(x * tile_size, y * tile_size)
					add_child(ins)
				2:
					var ins = emissor.instantiate()
					ins.rotation = deg_to_rad(90)
					ins.position = Vector2(x * tile_size, y * tile_size)
					add_child(ins)
				3:
					var ins = emissor.instantiate()
					ins.rotation = deg_to_rad(180)
					ins.position = Vector2(x * tile_size, y * tile_size)
					add_child(ins)
				4:
					var ins = emissor.instantiate()
					ins.rotation = deg_to_rad(270)
					ins.position = Vector2(x * tile_size, y * tile_size)
					add_child(ins)
				5:
					var ins = emissor.instantiate()
					ins.position = Vector2(x * tile_size, y * tile_size)
					add_child(ins)
				6:
					var ins = mirror.instantiate()
					ins.rotation = deg_to_rad(90)
					ins.position = Vector2(x * tile_size, y * tile_size)+(16*Vector2.ONE)
					add_child(ins)
				7:
					var ins = mirror.instantiate()
					ins.rotation = deg_to_rad(180)
					ins.position = Vector2(x * tile_size, y * tile_size)+(16*Vector2.ONE)
					add_child(ins)
				8:
					var ins = mirror.instantiate()
					ins.rotation = deg_to_rad(270)
					ins.position = Vector2(x * tile_size, y * tile_size)+(16*Vector2.ONE)
					add_child(ins)
				9:
					var ins = mirror.instantiate()
					ins.position = Vector2(x * tile_size, y * tile_size)+(16*Vector2.ONE)
					add_child(ins)
				10:
					var ins = reciver.instantiate()
					ins.position = Vector2(x * tile_size, y * tile_size)+(16*Vector2.ONE)
					add_child(ins)
				_:
					pass
	
	center_board(width, height)

func center_board(width, height):
	var board_width = width * tile_size
	var board_height = height * tile_size
	var screen_size = get_viewport_rect().size
	
	position = (screen_size - Vector2(board_width, board_height)) /2

func _ready() -> void:
	load_level((current_level))
	
func _process(delta):
	if Input.is_action_just_pressed("next_level"):
		current_level = (current_level + 1) % levels.size()
		load_level(current_level)

extends TileMapLayer

var camera

var levels = [
	[
		#level 1
		[1,0,1,0,1,0,1,0,1],
		[0,1,0,1,0,1,0,1,0],
		[1,0,1,0,1,0,1,0,1],
		[0,1,0,1,0,1,0,1,0],
		[3,3,3,3,3,3,3,3,3],
		[0,1,0,1,0,1,0,1,0],
		[1,0,1,0,1,0,1,0,1],
		[0,1,0,1,0,1,0,1,0],
		[1,0,1,0,1,0,1,0,1]
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

const MAX_BOARD_SIZE = 30

func load_level(level_index: int):
	clear()
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
			if board[y][x] == 1:
				var wall_instance = preload("res://scenes/cell.tscn").instantiate()
				wall_instance.position = Vector2(x * tile_size, y * tile_size)
				add_child(wall_instance)
			elif board[y][x] == 3:
				var wall_instance = preload("res://scenes/wall.tscn").instantiate()
				wall_instance.position = Vector2(x * tile_size, y * tile_size)
				add_child(wall_instance)
	
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

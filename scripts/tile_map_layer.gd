extends TileMapLayer

var camera

var levels = [
	[
		#level 1
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
		[1,0,1,0,1,1,0,1,0],
	],
	[#level 2
		[0,1,0,1,0],
		[1,1,0,1,1],
		[0,1,0,1,0],
		[0,1,0,1,1],
		[0,1,0,1,0]
	]
]

var tile_source_id = 0
var atlas_coords = Vector2i(0, 0)
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
				set_cell(Vector2i(x, y), tile_source_id, atlas_coords)
	
	center_board(width, height)
	adjust_zoom(width, height)

func center_board(width, height):
	var board_width = width * tile_size
	var board_height = height * tile_size
	var screen_size = get_viewport_rect().size
	
	position = (screen_size - Vector2(board_width, board_height)) /2

func adjust_zoom(width, height):
	var board_width = width * tile_size
	var board_height = height * tile_size
	var screen_size = get_viewport_rect().size
	
	#find center of the screen
	var zoom_x = screen_size.x / board_width
	var zoom_y = screen_size.y / board_height
	var best_zoom = min(zoom_x, zoom_y) * 0.9 #margin

func _ready() -> void:
	#camera = get_parent().get_node("Camera2D")
	load_level((current_level))
	
func _process(delta):
	if Input.is_action_just_pressed("next_level"):
		current_level = (current_level + 1) % levels.size()
		load_level(current_level)

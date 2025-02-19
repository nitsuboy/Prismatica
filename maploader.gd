extends TileMapLayer

# Define the levels

var levels = {
	"level_1": [
		[0, 0, 0, 0, 0],
		[0, 1, 1, 1, 0],
		[0, 1, 1, 1, 0],
		[0, 1, 1, 1, 0],
		[0, 0, 0, 0, 0]
	]
}

func load_level(level_name):
	if level_name in levels:
		var level_data = levels[level_name]
		draw_level(level_data)

func draw_level(level_data):
	clear()
	for y in range(len(level_data)):
		for x in range(len(level_data[y])):
			var tile_type = level_data[y][x]
			if tile_type == 1:
				set_cell(Vector2i(x, y), 0, Vector2i(0, 0)) 
				
				
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level("level_1")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

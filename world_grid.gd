extends TileMapLayer

const HOTSPOT_CHANCE = 0.10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generate_ph() -> void:
	var worldArray = get_used_cells()
	var startPos = get_used_rect().position
	for cell in worldArray:
		
		pass

extends TileMapLayer

const HOTSPOT_RAND_NUM = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generate_ph() -> void:
	var hotspotArray: Array[Vector2i] = []
	var worldArray = get_used_cells()
	var startPos = get_used_rect().position
	for cell in worldArray:
		if (!checkNeighborHotspots(hotspotArray, cell)):
			if (randi_range(1, HOTSPOT_RAND_NUM) == HOTSPOT_RAND_NUM):
				hotspotArray.append(cell)

func checkNeighborHotspots(hotspotArray: Array, cell: Vector2i) -> bool:
	if (hotspotArray.has(Vector2i(cell.x - 1, cell.y))):
		return true
	elif (hotspotArray.has(Vector2i(cell.x + 1, cell.y))):
		return true
	elif (hotspotArray.has(Vector2i(cell.x, cell.y - 1))):
		return true
	elif (hotspotArray.has(Vector2i(cell.x, cell.y + 1))):
		return true
	return false

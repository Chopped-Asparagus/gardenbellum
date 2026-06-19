extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var worldGrid = get_parent()
	generate_grass_soil(worldGrid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func generate_grass_soil(worldGrid: TileMapLayer) -> void:
	var worldCells = worldGrid.get_used_cells()
	for cell in worldCells:
		if (check_cells_exist(worldGrid, cell)):
			var mapString = get_cell_neighbor_data(worldGrid, cell)
			set_tile(cell, mapString)
			pass
	return

func check_cells_exist(worldGrid: TileMapLayer, cell: Vector2i) -> bool:
	var right = Vector2i(cell.x + 1, cell.y)
	var below = Vector2i(cell.x, cell.y + 1)
	var corner = Vector2i(cell.x + 1, cell.y + 1)
	if (worldGrid.get_cell_source_id(right) != -1 and worldGrid.get_cell_source_id(below) != -1 and worldGrid.get_cell_source_id(corner) != -1):
		return true
	return false

func get_cell_neighbor_data(worldGrid: TileMapLayer, cell: Vector2i) -> String:
	var right = Vector2i(cell.x + 1, cell.y)
	var below = Vector2i(cell.x, cell.y + 1)
	var corner = Vector2i(cell.x + 1, cell.y + 1)
	var finalString = ""
	if (worldGrid.get_cell_tile_data(cell).get_custom_data("ground") == "soil"):
		finalString += "1"
	else:
		finalString += "0"
	if (worldGrid.get_cell_tile_data(right).get_custom_data("ground") == "soil"):
		finalString += "1"
	else:
		finalString += "0"
	if (worldGrid.get_cell_tile_data(below).get_custom_data("ground") == "soil"):
		finalString += "1"
	else:
		finalString += "0"
	if (worldGrid.get_cell_tile_data(corner).get_custom_data("ground") == "soil"):
		finalString += "1"
	else:
		finalString += "0"
	return finalString
	
func set_tile(cell: Vector2i, tileString: String) -> void:
	var tileCoords = Vector2i()
	match tileString:
		"0000":
			tileCoords = Vector2i(0,0)
		"0001":
			tileCoords = Vector2i(1,0)
		"0010":
			tileCoords = Vector2i(3,0)
		"0011":
			tileCoords = Vector2i(2,0)
		"0100":
			tileCoords = Vector2i(1,2)
		"0101":
			tileCoords = Vector2i(1,1)
		"0110":
			tileCoords = Vector2i(0,1)
		"0111":
			tileCoords = Vector2i(0,3)
		"1000":
			tileCoords = Vector2i(3,2)
		"1001":
			tileCoords = Vector2i(0,2)
		"1010":
			tileCoords = Vector2i(3,1)
		"1011":
			tileCoords = Vector2i(1,3)
		"1100":
			tileCoords = Vector2i(2,2)
		"1101":
			tileCoords = Vector2i(3,3)
		"1110":
			tileCoords = Vector2i(2,3)
		"1111":
			tileCoords = Vector2i(2,1)
	self.set_cell(cell, 0, tileCoords)
	return

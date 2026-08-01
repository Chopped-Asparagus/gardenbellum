extends Control

const HEART_X_OFFSET = -35
const FULL_HEART_SPRITE = preload("res://Sprites/Util/HUD/Heart/full_heart.png")
const HALF_HEART_SPRITE = preload("res://Sprites/Util/HUD/Heart/half_heart.png")
const EMPTY_HEART_SPRITE = preload("res://Sprites/Util/HUD/Heart/empty_heart.png")

var heartArray

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func refresh_health(health: int) -> void:
	var tempHealth = health
	for heart in heartArray:
		if (tempHealth >= 2):
			heart.texture = FULL_HEART_SPRITE
			tempHealth -= 2
		elif (tempHealth == 1):
			heart.texture = HALF_HEART_SPRITE
			tempHealth -= 1
		else:
			heart.texture = EMPTY_HEART_SPRITE
	pass
	
func generate_heart_array(health: int) -> void:
	var heartNum = health / 2
	if (heartArray != null):
		for heart in heartArray:
			heart.queue_free()
	heartArray = []
	
	if (health % 2 != 0):
		heartNum += 1
	for i in heartNum:
		heartArray.append(Sprite2D.new())
		if (i == heartNum - 1 && health % 2 != 0):
			heartArray[i].texture = HALF_HEART_SPRITE
		else:
			heartArray[i].texture = FULL_HEART_SPRITE
		heartArray[i].position.x += i * HEART_X_OFFSET
		heartArray[i].scale.x = 2
		heartArray[i].scale.y = 2
		add_child(heartArray[i])

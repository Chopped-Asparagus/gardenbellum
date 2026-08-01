extends Node2D
class_name EnemyHandler

const curlyDockTimer = 3

var enemyCount = 3

@onready var enemyTimer = Timer.new()
@onready var curlyDockScene = preload("res://Scenes/Enemies/curly_dock_1.tscn")
@onready var scotchThistleScene = preload("res://Scenes/Enemies/scotch_thistle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyTimer.wait_time = curlyDockTimer
	enemyTimer.autostart = true
	enemyTimer.timeout.connect(_on_timeout)
	add_child(enemyTimer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_timeout() -> void:
	var scotchThistle = scotchThistleScene.instantiate()
	add_child(scotchThistle)
	enemyCount -= 1
	if (enemyCount == 0):
		enemyTimer.timeout.disconnect(_on_timeout)

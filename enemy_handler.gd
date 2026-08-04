extends Node2D
class_name EnemyHandler

const WAVE_LABEL_TIME = 3
const LOW_BOUND = Vector2(-100,-100)
const HIGH_BOUND = Vector2(3500,1400)

var timerSecs = 3.0
var enemyCount = 3
var wave = 0
var waveLeft = 0
var waveOver = true
var difficulty = 0
var started = false

@onready var phaseHandler = get_tree().current_scene
@onready var enemyTimer = Timer.new()
@onready var waveLabelTimer = Timer.new()
@onready var curlyDockScene = preload("res://Scenes/Enemies/curly_dock_1.tscn")
@onready var scotchThistleScene = preload("res://Scenes/Enemies/scotch_thistle.tscn")
@onready var hud = get_tree().get_first_node_in_group("hud")
@onready var waveLabel = hud.get_node("Wave Indicator")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (started):
		if (waveLeft == 0 && get_tree().get_nodes_in_group("enemies").size() == 0):
			waveOver = true
		if (waveOver):
			waveOver = false
			wave += 1
			phaseHandler.start_plan_phase()
		pass
	
func _spawn_enemy() -> void:
	var enemy = get_enemy().instantiate()
	enemy.position = get_random_start_pos()
	add_child(enemy)
	waveLeft -= 1
	if (waveLeft == 0):
		enemyTimer.timeout.disconnect(_spawn_enemy)
		
func get_random_start_pos() -> Vector2:
	var finalPos = Vector2(0,0)
	if (randi_range(0,1) == 0):
		if (randi_range(0,1) == 0):
			finalPos.x = LOW_BOUND.x
		else:
			finalPos.x = HIGH_BOUND.x
		finalPos.y = randi_range(LOW_BOUND.y, HIGH_BOUND.y)
	else:
		if (randi_range(0,1) == 0):
			finalPos.y = LOW_BOUND.y
		else:
			finalPos.y = HIGH_BOUND.y
		finalPos.x = randi_range(LOW_BOUND.x, HIGH_BOUND.x)
	return finalPos
	pass
	
func get_enemy() -> Object:
	if (randi_range(0,1) == 0):
		return curlyDockScene
	else:
		return scotchThistleScene
	pass
	
func start_wave() -> void:
	waveLeft = wave * enemyCount
	waveLabel.text = "Wave " + str(wave)
	waveLabel.visible = true
	waveLabelTimer.start()
	waveLabelTimer.timeout.connect(_on_wave_start)
	pass
	
func _on_wave_start() -> void:
	if (wave % 1 == 0):
		timerSecs *= 0.2
	enemyTimer.start(timerSecs)
	enemyTimer.timeout.connect(_spawn_enemy)
	waveLabel.visible = false
	waveLabelTimer.timeout.disconnect(_on_wave_start)
	waveLabelTimer.stop()
	pass
	
func start() -> void:
	waveLabelTimer.wait_time = WAVE_LABEL_TIME
	add_child(waveLabelTimer)
	add_child(enemyTimer)
	started = true
	pass

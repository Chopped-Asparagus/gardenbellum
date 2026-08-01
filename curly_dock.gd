extends CharacterBody2D
class_name CurlyDock

const SPEED = 120.0
const JUMP_VELOCITY = -400.0
const DAMAGE_TIME = 5
const PLAYER_GROUP = "players"

var damage = 1
var hp = 50
var currentDamageTime = 0
var prevDamageTime = 0
@onready var sprite = get_node("Sprite2D")
@onready var playerArray = get_tree().get_nodes_in_group(PLAYER_GROUP)

func _physics_process(delta: float) -> void:
	if (hp <= 0):
		queue_free()
	
	if (currentDamageTime >= 1):
		prevDamageTime = currentDamageTime
		currentDamageTime -= 1;
		if (currentDamageTime == DAMAGE_TIME - 1):
			sprite.set_instance_shader_parameter("red", true)
	elif (currentDamageTime == 0 && prevDamageTime == 1):
		prevDamageTime = 0
		sprite.set_instance_shader_parameter("red", false)
		
	var targetPosition = find_target()
	var angle = position.angle_to_point(targetPosition)
	velocity.x = cos(angle) * SPEED
	velocity.y = sin(angle) * SPEED

	if (position.distance_to(targetPosition) > 10):
		move_and_slide()

func find_target() -> Vector2:
	var finalVect = Vector2(0,0)
	var minDist = -1
	var target
	for player in playerArray:
		if (minDist == -1 || position.distance_to(player.position) < minDist):
			minDist = position.distance_to(player.position)
			finalVect = player.position
			pass
		pass
	
	
	return finalVect

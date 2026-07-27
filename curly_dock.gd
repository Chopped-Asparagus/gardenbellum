extends CharacterBody2D
class_name CurlyDock

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const DAMAGE_TIME = 5

var hp = 50
var currentDamageTime = 0
var prevDamageTime = 0
@onready var sprite = get_node("Sprite2D")

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

	move_and_slide()

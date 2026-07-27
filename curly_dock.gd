extends CharacterBody2D
class_name CurlyDock

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var hp = 50

func _physics_process(delta: float) -> void:
	if (hp <= 0):
		queue_free()

	move_and_slide()

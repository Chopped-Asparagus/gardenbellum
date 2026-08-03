extends Enemy
class_name ScotchThistle

const SPEED = 90.0

var damage = 1

func _ready() -> void:
	hp = 120
	load_enemy_damage_shader()
	pass

func _physics_process(delta: float) -> void:
	if (hp <= 0):
		handle_death()
	handle_enemy_default_shader()
		
	move_to_player(SPEED)

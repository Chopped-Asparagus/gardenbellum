extends Enemy
class_name CurlyDock

const SPEED = 120.0
const JUMP_VELOCITY = -400.0
const DAMAGE_TIME = 5

var damage = 1
var currentDamageTime = 0
var prevDamageTime = 0
var shaderLoad = preload("res://enemy_default.gdshader")
@onready var sprite = get_node("Sprite2D")

func _ready() -> void:
	hp = 40
	var shaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = shaderLoad
	material = shaderMaterial
	pass

func _physics_process(delta: float) -> void:
	if (hp <= 0):
		queue_free()
	
	if (currentDamageTime >= 1):
		prevDamageTime = currentDamageTime
		currentDamageTime -= 1;
		if (currentDamageTime == DAMAGE_TIME - 1):
			material.set_shader_parameter("red", true)
	elif (currentDamageTime == 0 && prevDamageTime == 1):
		prevDamageTime = 0
		material.set_shader_parameter("red", false)
		
	move_to_player(SPEED)

extends CharacterBody2D
class_name Enemy

const PLAYER_GROUP = "players"
const MAX_DAMAGE_SHADER_TIME = 6

@onready var playerArray = get_tree().get_nodes_in_group(PLAYER_GROUP)
@onready var goldCoin = preload("res://Scenes/Currency/gold_coin.tscn")

var hp
var damageShaderTime = 0
var value = 0

func take_damage(damage: int, type: String = "Normal") -> void:
	hp -= damage
	damageShaderTime = MAX_DAMAGE_SHADER_TIME
	pass
	
func move_to_player(speed: int) -> void:
	var targetPosition = find_target()
	var angle = position.angle_to_point(targetPosition)
	velocity.x = cos(angle) * speed
	velocity.y = sin(angle) * speed

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
	return finalVect
	
func load_enemy_damage_shader() -> void:
	var defaultShaderLoad = load("res://enemy_default.gdshader")
	var defaultShaderMat = ShaderMaterial.new()
	defaultShaderMat.shader = defaultShaderLoad
	material = defaultShaderMat
	
func handle_enemy_default_shader() -> void:
	if (damageShaderTime >= 1):
		damageShaderTime -= 1;
		if (damageShaderTime == MAX_DAMAGE_SHADER_TIME - 1):
			material.set_shader_parameter("red", true)
		elif (damageShaderTime == 0):
			material.set_shader_parameter("red", false)
			
func handle_death() -> void:
	create_coin()
	queue_free()
	pass
	
func create_coin() -> void:
	var coin = goldCoin.instantiate()
	coin.global_position = global_position
	get_tree().current_scene.add_child(coin)
	

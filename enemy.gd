extends CharacterBody2D
class_name Enemy

const PLAYER_GROUP = "players"

@onready var playerArray = get_tree().get_nodes_in_group(PLAYER_GROUP)

var hp

func take_damage(damage: int, type: String) -> void:
	hp -= damage
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

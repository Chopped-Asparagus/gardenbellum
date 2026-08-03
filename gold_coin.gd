extends Area2D
class_name GoldCoin

var value = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playerArray = get_tree().get_nodes_in_group("players")
	for player in playerArray:
		body_entered.connect(on_player_entered)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_player_entered(body: Node2D) -> void:
	var hud = get_tree().get_first_node_in_group("hud")
	hud.increase_currency(value)
	queue_free()
	pass

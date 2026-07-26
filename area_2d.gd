extends Area2D

const ENEMY_GROUP = "enemies"
const ANTLER_DAMAGE = 30

@onready var enemyArray = get_tree().get_nodes_in_group(ENEMY_GROUP)
var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in enemyArray.size():
		enemyArray[i].area_entered.connect(_on_area_entered.bind(ANTLER_DAMAGE, enemyArray[i]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_area_entered(area: Area2D, damage: int, enemy: Node) -> void:
	if (active):
		enemy.hp -= damage

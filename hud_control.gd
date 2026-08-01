extends Control

const heartVal = 5
@onready var heartNode = get_node("Hearts")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func refresh_health(health: int) -> void:
	heartNode.refresh_health(health)
	
func generate_heart_array(health: int) -> void:
	if (heartNode == null):
		heartNode = get_node("Hearts")
	heartNode.generate_heart_array(health)

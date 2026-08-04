extends Node2D

const defensePhase = "defense"
const planPhase = "plan"

@onready var eh = get_tree().get_first_node_in_group("enemy handler")

var currentPhase = defensePhase
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_defense_phase()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func start_defense_phase() -> void:
	eh.start()
	pass
	
func start_plan_phase() -> void:
	
	pass

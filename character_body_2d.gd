extends CharacterBody2D

const SPEED = 300.0
const DIAG_MOD = 0.707
const TORSO_INDEX = 1
const ANTLER_RIGID_BODY_INDEX = 6
const ANTLER_SUB_INDEX = 0
const ANTLER_OFFSET = -8
const ANTLER_THROW_DIST = 300
const FLIP_OFFSET = 2
const CHARACTER_TYPE = "MOOSE"

var attackDisabled = false


func _physics_process(_delta: float) -> void:
	
	handle_movement()
	
	if (CHARACTER_TYPE == "MOOSE"):
		handle_antler_throw()

func handle_movement():
	var torso = self.get_child(TORSO_INDEX)
	var antlerRigidBody = self.get_child(ANTLER_RIGID_BODY_INDEX)
	var antler = antlerRigidBody.get_child(ANTLER_SUB_INDEX)
	
	#handle movement
	
	velocity.x = 0
	velocity.y = 0
	
	if (Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left")):
		torso.position.x = 0
		torso.flip_h = false
		antler.flip_h = false
		antlerRigidBody.position.x = ANTLER_OFFSET
		if (Input.is_action_pressed("move_up") != Input.is_action_pressed("move_down")):
			velocity.x = SPEED * DIAG_MOD
			if (Input.is_action_pressed("move_up")):
				velocity.y = -SPEED * DIAG_MOD
			else:
				velocity.y = SPEED * DIAG_MOD
		else:
			velocity.x = SPEED
	elif (Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right")):
		torso.position.x = FLIP_OFFSET
		torso.flip_h = true
		antler.flip_h = true
		antlerRigidBody.position.x = -ANTLER_OFFSET + FLIP_OFFSET
		if (Input.is_action_pressed("move_up") != Input.is_action_pressed("move_down")):
			velocity.x = -SPEED * DIAG_MOD
			if (Input.is_action_pressed("move_up")):
				velocity.y = -SPEED * DIAG_MOD
			else:
				velocity.y = SPEED * DIAG_MOD
		else:
			velocity.x = -SPEED
	elif (Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_down")):
		velocity.y = -SPEED
	elif (Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up")):
		velocity.y = SPEED
		
	move_and_slide()
	
func handle_antler_throw():
	var antlerRigidBody = self.get_child(ANTLER_RIGID_BODY_INDEX)
	var antler = antlerRigidBody.get_child(ANTLER_SUB_INDEX)
	if (Input.is_action_just_pressed("primary_attack") && attackDisabled == false):
		
		pass

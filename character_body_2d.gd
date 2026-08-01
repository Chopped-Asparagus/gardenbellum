extends CharacterBody2D

const SPEED = 300.0
const DIAG_MOD = 0.707
const TORSO_INDEX = 1
const ANTLER_BODY_INDEX = 6
const ANTLER_SUB_INDEX = 0
const ANTLER_OFFSET = -8
const FLIP_OFFSET = 2
const CHARACTER_TYPE = "MOOSE"
const FOOT_SPEED = 0.2
const FOOT_MAX = 1.4
const FORWARD_FOOT_POS = Vector2(-6.0,38.0)
const BACK_FOOT_POS = Vector2(8.0,38.0)
const I_FRAME_MAX = 40
const RED_FRAME_MAX = 10

var attackDisabled = false
var antlerThrown = false
var flipped = false
var forwardFootMoved = 0
var backFootMoved = 0
var footDirection = false
var maxHealth = 6
var health = maxHealth
var iFrames = 0
var redFrames = 0

@onready var forwardFoot = get_node("ForwardFoot")
@onready var backFoot = get_node("BackFoot")
@onready var hud = get_tree().get_first_node_in_group("hud")

func _ready() -> void:
	hud.generate_heart_array(health)

func _physics_process(_delta: float) -> void:
	
	handle_movement()
	if (iFrames > 0):
		iFrames -= 1
	if (iFrames % 4 > 1):
		visible = false
	else:
		visible = true
		
	if (redFrames > 0):
		redFrames -= 1
		material.set_shader_parameter("red", true)
	else:
		material.set_shader_parameter("red", false)
	
	if (CHARACTER_TYPE == "MOOSE"):
		handle_antler_throw()

func handle_movement():
	var torso = self.get_child(TORSO_INDEX)
	var antlerBody = self.get_child(ANTLER_BODY_INDEX)
	var antler = antlerBody.get_child(ANTLER_SUB_INDEX)
	
	velocity.x = 0
	velocity.y = 0
	
	if (Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left")):
		torso.position.x = 0
		torso.flip_h = false
		flipped = false
		if (!antlerThrown):
			antler.flip_h = false
			antlerBody.position.x = ANTLER_OFFSET
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
		flipped = true
		if (!antlerThrown):
			antler.flip_h = true
			antlerBody.position.x = -ANTLER_OFFSET + FLIP_OFFSET
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
	
	if (velocity.x != 0 || velocity.y != 0):
		move_feet()
		pass
	
func handle_antler_throw():
	var antlerBody = self.get_child(ANTLER_BODY_INDEX)
	var antler = antlerBody.get_child(ANTLER_SUB_INDEX)
	if (Input.is_action_just_pressed("primary_attack") && !attackDisabled && !antlerThrown):
		antlerBody.begin_throw()
		antlerThrown = true
		pass
		
func move_feet() -> void:
	if (footDirection):
		if (backFoot.position.y < FOOT_MAX + FORWARD_FOOT_POS.y):
			forwardFoot.position.y -= FOOT_SPEED
			backFoot.position.y += FOOT_SPEED
			pass
		else:
			footDirection = false
	else:
		if (forwardFoot.position.y < FOOT_MAX + FORWARD_FOOT_POS.y):
			forwardFoot.position.y += FOOT_SPEED
			backFoot.position.y -= FOOT_SPEED
		else:
			footDirection = true
	pass
	
func take_damage(damage: int, type: String = "normal") -> void:
	if (iFrames == 0):
		health -= damage
		hud.refresh_health(health)
		iFrames = I_FRAME_MAX
		redFrames = RED_FRAME_MAX
	pass

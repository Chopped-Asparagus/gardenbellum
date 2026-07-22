extends CharacterBody2D

const APEX_DIST = 400000
const SPEED_MAX = 700
const DIST_MOD = 0.001
const RETURN_MOD = 0.04
const Y_OFFSET = -38
const X_OffSET = -8
const FLIP_OFFSET = 2
const ROTATE_MOD = 0.2
const SPRITE_INDEX = 0
const COLLIDER_INDEX = 1

@onready var parent = self.get_parent()
@onready var collider = self.get_child(COLLIDER_INDEX)
var thrown = false
var returning = false
var throwAngle = 0
var distTraveled = 0
var speed = SPEED_MAX
var rotationAccumulated = 0
@onready var sprite = self.get_child(SPRITE_INDEX)

func _physics_process(delta: float) -> void:
	if (thrown):
		handle_throw(throwAngle)
	elif (returning):
		handle_return()
	if (thrown or returning):
		handle_spin()
		handle_collision()
	
func begin_throw() -> void:
	speed = SPEED_MAX
	throwAngle = get_angle_to(get_global_mouse_position())
	thrown = true
	var tempX = global_position.x
	var tempY = global_position.y
	top_level = true
	position.x = tempX
	position.y = tempY
	
func handle_throw(angle: float) -> void:
	velocity.x = cos(angle) * speed
	velocity.y = sin(angle) * speed
	distTraveled += speed
	speed = speed - distTraveled * DIST_MOD
	if (speed < 30):
		thrown = false
		returning = true
		distTraveled = 0
	move_and_slide()
	
func handle_return() -> void:
	var target = parent.position
	target.y += Y_OFFSET
	if (parent.flipped):
		target.x -= X_OffSET + FLIP_OFFSET
	else:
		target.x += X_OffSET
	throwAngle = get_angle_to(target) + rotationAccumulated
	velocity.x = cos(throwAngle) * speed
	velocity.y = sin(throwAngle) * speed
	distTraveled += speed
	if (speed > SPEED_MAX):
		speed = SPEED_MAX
	else:
		speed = speed + distTraveled * RETURN_MOD
	move_and_slide()
	if (position.distance_to(parent.position) < 50):
		top_level = false
		speed = 0
		if (parent.flipped):
			position.x = -X_OffSET + FLIP_OFFSET
			sprite.flip_h = true
		else:
			position.x = X_OffSET
			sprite.flip_h = false
		position.y = Y_OFFSET
		returning = false
		distTraveled = 0
		parent.antlerThrown = false
		rotation_degrees = 0
		rotationAccumulated = 0

func handle_spin() -> void:
	self.rotate(ROTATE_MOD)
	rotationAccumulated += ROTATE_MOD
	pass
	
func handle_collision() -> void:
	if (collider.)
	pass

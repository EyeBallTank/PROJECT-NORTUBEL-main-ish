extends KinematicBody2D

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 70
var PUSH_SPEED = 150
var STOP_FORCE = 450
var JUMP_SPEED = 1990

export var gravity: = 30000.0

var velocity: = Vector2.ZERO
var direction = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

func _ready():
	pass

func _physics_process(delta):
	if Player.global_position.x < global_position.x - 10:
		velocity.x = WALK_MAX_SPEED
		direction.x = -1
	elif Player.global_position.x > global_position.x + 10:
		velocity.x = -WALK_MAX_SPEED
		direction.x = 1
	else:
		velocity.x = 0
		direction.x = 0
	velocity.x = direction.x * 280
	
	
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	
	if is_on_floor() and Player.global_position.y < global_position.y - 10:
		velocity.y = -JUMP_SPEED
		if velocity.y < 0:
			velocity.y += 500

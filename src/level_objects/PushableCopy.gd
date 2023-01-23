extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

enum {
	PUSHED,
	FROZEN
}

var state = FROZEN

var velocity: = Vector2.ZERO

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var STOP_FORCE = 900
var JUMP_SPEED = 1500

func _physics_process(delta):
	match state:
		FROZEN:
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)

			velocity.y += gravity * delta

			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

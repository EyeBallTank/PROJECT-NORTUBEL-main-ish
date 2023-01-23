extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

var velocity: = Vector2.ZERO

const WALK_FORCE = 1600
const WALK_MAX_SPEED = 700
const STOP_FORCE = 900
const JUMP_SPEED = 1500

func _physics_process(delta):
	velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)

	velocity.y += gravity * delta

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

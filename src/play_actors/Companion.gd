extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

var velocity: = Vector2.ZERO

onready var Player = get_parent().get_node("Player")

var direction = Vector2.RIGHT

#func get_direction():
func _physics_process(delta):
	if Player.global_position.x < global_position.x - 1:
		direction.x = -1
	elif Player.global_position.x > global_position.x + 1:
		direction.x = 1
	else:
		direction.x = 0
	velocity = direction * 290
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP)

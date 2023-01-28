extends KinematicBody2D
class_name PushableCopy

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

var player_lenght = 64

onready var pushableside = $leftandrightside

func _physics_process(delta):
	match state:
		FROZEN:
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)

			velocity.y += gravity * delta

			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
#
		PUSHED:
			WALK_MAX_SPEED = 150
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
				state = FROZEN

#func push(velocity: Vector2) -> void:
#	move_and_slide(velocity, Vector2())


#func _on_Area2D_body_entered(body):
#	if body.name == "Player":
#		get_parent().global_position.x= get_parent().get_node("Player").global_position.x + player_lenght
#		velocity.x = WALK_MAX_SPEED

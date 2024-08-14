extends KinematicBody2D

export var gravity: = 23600
var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprites = $AnimatedSprite

enum {
	STARTPLACE,
	FLYING,
	VICTORY
}

var state = STARTPLACE

func _ready():
	pass

func _physics_process(delta):
	pass

	match state:
		STARTPLACE:
			velocity.x = 0

		FLYING:
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		VICTORY:
			pass

extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT
var speed = 30

func _ready():
	pass

func _physics_process(delta):
	if is_on_wall():
		pass
	velocity.x = speed * 10
	move_and_slide(velocity, Vector2.UP)


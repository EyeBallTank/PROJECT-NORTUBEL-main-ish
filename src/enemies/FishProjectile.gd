extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT


func _ready():
	pass

func _physics_process(delta):
	if is_on_wall():
		queue_free()
#	velocity = direction * 1000
	move_and_slide(direction, Vector2.UP)


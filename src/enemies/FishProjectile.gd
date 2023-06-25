extends KinematicBody2D


func _ready():
	pass

func _physics_process(delta):
	if is_on_wall():
		queue_free()

extends KinematicBody2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")

func die():
	queue_free()

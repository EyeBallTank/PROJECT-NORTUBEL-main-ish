extends KinematicBody2D


onready var player = get_parent().get_node("Player/EatableHead")

func _physics_process(delta):
	global_position = player.global_position 

extends KinematicBody2D

#USED IN ANY LEVEL WITH THE GHALBEEN
#THERE COULD BE BETTER METHODS BUT WHATEVER

onready var player = get_parent().get_node("Player/EatableHead")

func _physics_process(delta):
	global_position = player.global_position 

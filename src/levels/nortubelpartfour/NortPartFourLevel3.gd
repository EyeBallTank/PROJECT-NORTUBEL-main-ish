extends Node2D

onready var animation = $AnimationPlayer 

#Just in case
func _ready():
	animation.play("RESET")

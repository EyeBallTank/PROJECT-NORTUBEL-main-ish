extends Node2D

onready var animationplayer = $AnimationPlayer
export var animation = "mainloop"

func _ready():
	animationplayer.play(animation)

extends Node2D

onready var animationplayer = $AnimationPlayer
export var animation = "HorizontalPlat"

func _ready():
	animationplayer.play(animation)

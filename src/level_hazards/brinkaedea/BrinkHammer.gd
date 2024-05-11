extends Node2D

onready var animationplayer = $AnimationPlayer
export var animation = "RESET"


func _ready():
	animationplayer.play(animation)

extends Node2D

onready var animationplayer = $AnimationPlayer
export var animation = "HorizontalPlat"

onready var sprite = $Platform/Sprite
export var spritename = "nortubel movplathoriz"

func _ready():
	animationplayer.play(animation)
	sprite.animation = spritename

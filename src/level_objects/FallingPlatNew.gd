extends Node2D

onready var animationplayer = $AnimationPlayer
onready var sprite = $Platform/Sprite
export var spritename = "nortubel fallplat"

func _ready():
	sprite.animation = spritename

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		animationplayer.play("ShakeNFall")

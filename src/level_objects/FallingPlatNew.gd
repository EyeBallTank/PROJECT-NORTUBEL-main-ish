extends Node2D

onready var animationplayer = $AnimationPlayer


func _ready():
	pass 


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		animationplayer.play("ShakeNFall")

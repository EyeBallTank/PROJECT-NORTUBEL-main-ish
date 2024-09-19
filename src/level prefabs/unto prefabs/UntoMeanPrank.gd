extends Node2D


onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")


func _on_YoureInForAScare_body_entered(body):
	if body.name == "Player":
		animationplayer.play("BOO")

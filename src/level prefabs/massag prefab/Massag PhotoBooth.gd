extends Node2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET") 


func _on_Takeaphoto_body_entered(body):
	if body.name == "Player":
		animation.play("phototaken")

extends StaticBody2D

onready var animation = $AnimationPlayer


func _ready():
	pass 

#maybe the animation could be tweaked in the future

func _on_Area2D_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("BallsBounce")


func _on_Area2D_body_exited(body):
	if body.is_in_group("protagonists"):
		animation.play("BallsBounce")

extends Area2D

func _ready():
	pass 

func _on_Blue_key_body_entered(body):
	if body.name == "Player":
		queue_free()

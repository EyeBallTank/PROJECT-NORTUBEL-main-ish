extends Area2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.get_hurt()
#	if body.name == "Companion":
#		body.get_hurted()

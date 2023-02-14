extends StaticBody2D

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.hasredkey == true:
			queue_free()
		else:
			pass

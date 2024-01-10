extends Area2D



func _ready():
	pass

func _on_NortRaceFlag_body_entered(body):
	if body.is_in_group("protagonists"):
		pass

	if body.is_in_group("rival"):
		pass

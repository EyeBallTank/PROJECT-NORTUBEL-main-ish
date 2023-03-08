extends Area2D


func _ready():
	pass

func _on_Coin_body_entered(body):
	if body.is_in_group("protagonists"):
		queue_free()

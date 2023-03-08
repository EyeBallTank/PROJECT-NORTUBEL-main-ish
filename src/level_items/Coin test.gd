extends Area2D


func _ready():
	pass

func _on_Coin_body_entered(body):
	if body.is_in_group("protagonists"):
		Signals.emit_signal("coin_was_captured")
		queue_free()

extends Area2D

func _ready():
	pass 

func _on_Blue_key_body_entered(body: PhysicsBody2D):
	if body.name == "Player":
		body.hasbluekey = true
		queue_free()

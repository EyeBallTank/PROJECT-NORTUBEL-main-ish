extends Area2D

func _ready():
	pass 

func _on_Yellow_key_body_entered(body: PhysicsBody2D):
	if body.name == "Player":
		body.hasyellowkey = true
		queue_free()


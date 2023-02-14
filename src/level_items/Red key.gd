extends Area2D

func _ready():
	pass 

func _on_Red_key_body_entered(body: PhysicsBody2D):
	if body.name == "Player":
		body.hasredkey = true
		queue_free()

extends Area2D


func _ready():
	pass 




func _on_Health_Pickup_body_entered(body):
	if body.name == "Player":
		body.health += 10
		queue_free()

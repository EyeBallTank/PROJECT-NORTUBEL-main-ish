extends Area2D


func _ready():
	pass 




func _on_Health_Pickup_body_entered(body):
	if body.name == "Player":
		if body.health < 100:
			body.health += 10
			queue_free()
		else:
			pass

	if body.name == "Companion":
		if body.health < 50:
			body.health += 10
			queue_free()
		else:
			pass

#Wanted to make sure one character touching the Health Pickup heals BOTH
#But it seems the Companion cannot obtain the Health Pickup to heal

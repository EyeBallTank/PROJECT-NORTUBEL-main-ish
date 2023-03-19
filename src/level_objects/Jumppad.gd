extends Area2D


func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.velocity.y = -2000
		body.move_and_slide(body.velocity)
	if body.name == "Companion":
		body.vel.y = -200
		body.move_and_slide(body.vel)

#CODE COPIED FROM hellofellowjell-0186 ON YOUTUBE

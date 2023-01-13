extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.velocity.y = -2000
		body.move_and_slide(body.velocity)

	if body.name == "Companion":
		body.vel.y = -2000
		body.move_and_slide(body.vel)
#CODE COPIED FROM hellofellowjell-0186 ON YOUTUBE

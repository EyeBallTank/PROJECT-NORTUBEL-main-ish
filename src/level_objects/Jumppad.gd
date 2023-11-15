extends Area2D
tool

onready var audioPlayer = $AudioStreamPlayer

onready var sprite = $Sprite
export var spritename = "nortubel jumppad"

func _ready():
	pass
	sprite.animation = spritename

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		audioPlayer.play()
		body.velocity.y = -2000
		body.move_and_slide(body.velocity)
	if body.name == "Companion":
		audioPlayer.play()
		body.vel.y = -1500
		body.move_and_slide(body.vel)
	if body.is_in_group("rival"):
		audioPlayer.play()
		body.velocity.y = -2000
		body.move_and_slide(body.velocity)

#CODE COPIED FROM hellofellowjell-0186 ON YOUTUBE

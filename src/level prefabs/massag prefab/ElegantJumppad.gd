extends Node2D

onready var audioPlayer = $AudioStreamPlayer


func _ready():
	pass



func _on_jumpdetect_body_entered(body):
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

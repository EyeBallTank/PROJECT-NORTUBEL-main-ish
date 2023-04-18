extends Area2D

onready var audioPlayer = $AudioStreamPlayer

func _ready():
	pass

func _on_SoccerBallBag_body_entered(body):
	if body.name == "Player" and body.hasball == false:
		body.hasball = true
		audioPlayer.play()
	else:
		pass

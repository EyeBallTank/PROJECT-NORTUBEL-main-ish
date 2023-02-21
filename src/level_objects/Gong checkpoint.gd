extends Area2D

onready var audioPlayer = $AudioStreamPlayer

func _ready():
	pass


func _on_Gong_body_entered(body):
	if body.is_in_group("protagonists"):
		audioPlayer.play()

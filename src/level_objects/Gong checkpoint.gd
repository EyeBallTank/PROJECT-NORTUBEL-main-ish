extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

func _ready():
	pass


func _on_Gong_body_entered(body):
	if body.is_in_group("protagonists"):
		audioPlayer.play()
		animationplayer.play("TOUCHED")

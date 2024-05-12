extends Node2D

onready var animationplayer = $AnimationPlayer
export var animation = "RESET"
onready var sound = $AudioStreamPlayer

func _ready():
	animationplayer.play(animation)


func _on_SoundArea_body_entered(body):
	if body.is_in_group("protagonists"):
		sound.play()

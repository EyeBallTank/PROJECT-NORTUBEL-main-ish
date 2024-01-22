extends Node2D

onready var audio = $water/AudioStreamPlayer

func _ready():
	pass


func _on_water_body_entered(body):
	if body.is_in_group("protagonists"):
		audio.play()

#All this over a sound.
#Hope this doesn't ruin the potential of level songs or anything.

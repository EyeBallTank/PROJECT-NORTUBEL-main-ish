extends Node2D


onready var animation = $AnimationPlayer


func _ready():
	animation.play("RESET")


func _on_DetectPlayer_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("hatchet")
		Signals.emit_signal("bonkette_song_must_play")

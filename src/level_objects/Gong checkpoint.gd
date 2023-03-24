extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

var active = false

func _on_Gong_body_entered(body):
#	if body.is_in_group("protagonists"):
	if not active:
		if body.last_checkpoint != null:
			body.last_checkpoint.desactivate()
		body.last_checkpoint = self
		audioPlayer.play()
		animationplayer.play("TOUCHED")
		active = true
#		Signals.emit_signal("hit_checkpoint", position)
#		if body.health == 0:
#			body.global_position = global_position

func desactivate():
	active = false

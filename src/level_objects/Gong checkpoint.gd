extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

var active = false

onready var Player = get_parent().get_node("Player")
onready var Companion = get_parent().get_node("Companion")

func _on_Gong_body_entered(body):
#	if body.is_in_group("protagonists"):
	if not active:
		if body.last_checkpoint != null:
			body.last_checkpoint.desactivate()
		Player.last_checkpoint = self
		Companion.last_checkpoint = self
		audioPlayer.play()
		animationplayer.play("TOUCHED")
		active = true
#		Signals.emit_signal("hit_checkpoint", position)
#		if body.health == 0:
#			body.global_position = global_position

func desactivate():
	active = false

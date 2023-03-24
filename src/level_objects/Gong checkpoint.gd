extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

var active = true

func _ready():
	if not active: return
	pass

func _on_Gong_body_entered(body):
	if body.is_in_group("protagonists"):
		audioPlayer.play()
		animationplayer.play("TOUCHED")
		active = false
		Signals.emit_signal("hit_checkpoint", position)

extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")
	pass

func _on_Coin_body_entered(body):
	if body.is_in_group("protagonists"):
		Signals.emit_signal("coin_was_captured")
		animationplayer.play("collected")
		audioPlayer.play()
#		yield(animationplayer, "animation_finished")
#		queue_free()

func disappear():
	queue_free()

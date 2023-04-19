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
		yield(get_tree().create_timer(0.8), "timeout")
		queue_free()

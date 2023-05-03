extends Area2D

#Failed goal: Making the coin unpickable when the player reaches max lives
#The coin is still pickable somehow

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

func _ready():
#	animationplayer.play("Uncollectable")
	animationplayer.play("RESET")

func _on_Coin_body_entered(body):
	if body.is_in_group("protagonists"):
		if Signals.lives < Signals.max_lives:
			Signals.emit_signal("coin_was_captured")
			animationplayer.play("collected")
			audioPlayer.play()
#		elif Signals.lives == Signals.max_lives:
#			animationplayer.play("Uncollectable")
#	elif body.is_in_group("protagonists") and Signals.lives == Signals.max_lives:
#		animationplayer.play("Uncollectable")
#		yield(animationplayer, "animation_finished")
#		queue_free()

func disappear():
	queue_free()

#func _physics_process(_delta):
#	if Signals.lives == Signals.max_lives:
#		animationplayer.play("Uncollectable")
#		pass
#		self.set_monitoring(false)
#		self.set_monitorable(false)
#		$CollisionShape2D.disabled = true

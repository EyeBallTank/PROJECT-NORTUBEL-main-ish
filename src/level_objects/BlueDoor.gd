extends StaticBody2D

onready var animationplayer = $AnimationPlayer

func _ready():
	$AnimationPlayer.play("RESET")
	pass 

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.hasbluekey == true:
			$AudioStreamPlayer.play()
			animationplayer.play("unlocked")
			yield(animationplayer, "animation_finished")
			queue_free()
		else:
			pass


extends StaticBody2D

func _ready():
	$AnimationPlayer.play("RESET")
	pass 

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.hasbluekey == true:
			$AudioStreamPlayer.play()
			$AnimationPlayer.play("unlocked")
			yield(get_tree().create_timer(0.6), "timeout")
			queue_free()
		else:
			pass


extends StaticBody2D
tool

onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "nortubel reddoor"

func _ready():
	sprite.animation = spritename
	$AnimationPlayer.play("RESET")
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.hasredkey == true:
			$AudioStreamPlayer.play()
			animationplayer.play("unlocked")
#			yield(animationplayer, "animation_finished")
#			queue_free()
		else:
			pass

func disappear():
	queue_free()

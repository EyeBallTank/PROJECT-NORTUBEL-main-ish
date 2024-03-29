extends Area2D
tool

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "nortubel health"

func _ready():
	sprite.animation = spritename
	animationplayer.play("RESET")
	pass 

func _on_Health_Pickup_body_entered(body):
	if body.name == "Player":
		if body.health < 100:
			body.health += 10
			animationplayer.play("collected")
			audioPlayer.play()
#			yield(animationplayer, "animation_finished")
#			queue_free()
		else:
			pass

	if body.name == "Companion":
		if body.health < 50:
			body.health += 10
			animationplayer.play("collected")
			audioPlayer.play()
#			yield(animationplayer, "animation_finished")
#			queue_free()
	if body.name == "StellaComp":
		if body.health < 100:
			body.health += 10
			animationplayer.play("collected")
			audioPlayer.play()

		else:
			pass

func disappear():
	queue_free()

#Wanted to make sure one character touching the Health Pickup heals BOTH

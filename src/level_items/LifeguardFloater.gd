extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")
	pass


func _on_LifeguardFloater_body_entered(body):
	if body.name == "Player":
		body.is_invul()
		audioPlayer.play()
		animationplayer.play("caught")
#		yield(animationplayer, "animation_finished")
#		queue_free()

func disappear():
	queue_free()

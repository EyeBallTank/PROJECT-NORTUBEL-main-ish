extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")
	pass


func _on_LifeguardFloater_body_entered(body):
	if body.is_in_group("protagonists"):
		body.is_invul()
		audioPlayer.play()
		animationplayer.play("caught")
		yield(get_tree().create_timer(0.8), "timeout")
		queue_free()

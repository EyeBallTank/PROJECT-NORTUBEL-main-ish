extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")
	pass 

func _on_Yellow_key_body_entered(body: PhysicsBody2D):
	if body.name == "Player":
		body.hasyellowkey = true
		audioPlayer.play()
		animationplayer.play("caughtkey")
		yield(get_tree().create_timer(0.9), "timeout")
		queue_free()
		

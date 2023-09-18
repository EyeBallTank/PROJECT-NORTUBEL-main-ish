extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "nortubel yelkey"

func _ready():
	sprite.animation = spritename
	animationplayer.play("RESET")
	pass 

func _on_Yellow_key_body_entered(body: PhysicsBody2D):
	if body.name == "Player":
		body.hasyellowkey = true
		audioPlayer.play()
		animationplayer.play("caughtkey")
#		yield(animationplayer, "animation_finished")
#		queue_free()
		

func disappear():
	queue_free()

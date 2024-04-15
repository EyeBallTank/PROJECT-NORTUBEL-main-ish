extends Area2D
tool

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "nortubel redkey"

func _ready():
	sprite.animation = spritename
	animationplayer.play("RESET")
	pass 

func _on_Red_key_body_entered(body: PhysicsBody2D):
	if body.name == "Player":
		body.hasredkey = true
		audioPlayer.play()
		animationplayer.play("caughtkey")
#		yield(animationplayer, "animation_finished")
#		queue_free()
		

func disappear():
	queue_free()

extends Area2D
tool

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "nortubel blukey"

func _ready():
	sprite.animation = spritename
	animationplayer.play("RESET")
	pass 

func _on_Blue_key_body_entered(body: PhysicsBody2D):
	if body.name == "Player":
		body.hasbluekey = true
		audioPlayer.play()
		animationplayer.play("caughtkey")
#		yield(animationplayer, "animation_finished")
#		queue_free()
		

func disappear():
	queue_free()

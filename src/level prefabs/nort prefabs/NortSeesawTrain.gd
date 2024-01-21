extends Node2D

onready var sprite =  $KinematicBody2D/AnimatedSprite
onready var animationplayer = $AnimationPlayer
var playertouch = false
var comptouch = false


#NOTE: MAKE THE "PATH" LONGER
#MAKE IT THAT EITHER BOTH CHARACTERS ARE NEEDED OR THE PLAYER USES AN INPUT (maybe both)

func _ready():
	animationplayer.play("RESET")
	sprite.play("default")

func _physics_process(delta):
	if playertouch == true and comptouch == true:
		if Input.is_action_just_pressed("standstill"):
			animationplayer.play("moving")
			sprite.play("moving")
		elif Input.is_action_just_pressed("runaway"):
			animationplayer.stop(false)
			sprite.play("default")
	elif playertouch == false or comptouch == false:
		animationplayer.stop(false)
		sprite.play("default")

func _on_CharacterDetect_body_entered(body):
#	if body.is_in_group("protagonists"):
#		animationplayer.play("moving")
#		sprite.play("moving")
	if body.name == "Player":
		playertouch = true
	if body.name == "Companion":
		comptouch = true

func _on_CharacterDetect_body_exited(body):
#	if body.is_in_group("protagonists"):
#		animationplayer.stop(false)
#		sprite.play("default")
	if body.name == "Player":
		playertouch = false
	if body.name == "Companion":
		comptouch = false

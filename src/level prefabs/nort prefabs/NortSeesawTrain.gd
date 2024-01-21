extends Node2D

onready var sprite =  $KinematicBody2D/AnimatedSprite
onready var animationplayer = $AnimationPlayer

#NOTE: MAKE THE "PATH" LONGER
#MAKE IT THAT EITHER BOTH CHARACTERS ARE NEEDED OR THE PLAYER USES AN INPUT (maybe both)

func _ready():
	animationplayer.play("RESET")
	sprite.play("default")



func _on_CharacterDetect_body_entered(body):
	if body.is_in_group("protagonists"):
		animationplayer.play("moving")
		sprite.play("moving")


func _on_CharacterDetect_body_exited(body):
	if body.is_in_group("protagonists"):
		animationplayer.stop(false)
		sprite.play("default")

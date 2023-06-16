extends Area2D

var is_pressed = false
onready var animatedsprite = $AnimatedSprite
onready var animationplayer = $AnimationPlayer


func _ready():
	animatedsprite.animation = "unpressed"
	animationplayer.play("UNPRESSED")


func _on_FloorSwitch_body_entered(body):
	if body.is_in_group("pushable"):
		is_pressed = true
		animatedsprite.animation = "pressed"
		animationplayer.play("PRESSED")
	else:
		pass

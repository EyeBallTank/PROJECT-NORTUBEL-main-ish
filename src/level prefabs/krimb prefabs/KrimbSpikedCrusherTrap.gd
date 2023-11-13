extends Node2D

onready var switchsprite = $YellowSwitch/AnimatedSprite
onready var animation = $AnimationPlayer

var is_pressed = false

func _ready():
	switchsprite.play("switchoff")
	animation.play("RESET")



func _on_YellowSwitch_body_entered(body):
	if body.name == "StellaComp":
		animation.play("active")

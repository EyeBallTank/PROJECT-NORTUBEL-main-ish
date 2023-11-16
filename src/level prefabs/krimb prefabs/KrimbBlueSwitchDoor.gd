extends Node2D

onready var switchsprite = $BlueSwitch/AnimatedSprite
onready var animation = $AnimationPlayer

func _ready():
	switchsprite.play("switchon")
	animation.play("RESET")



func _on_BlueSwitch_body_entered(body):
	if body.name == "StellaComp":
		animation.play("active")

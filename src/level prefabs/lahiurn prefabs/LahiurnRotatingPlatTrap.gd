extends Node2D

onready var switchsprite = $BlueSwitch/AnimatedSprite
onready var animation = $AnimationPlayer

func _ready():
	switchsprite.play("switchon")
	animation.play("RESET")


func _on_BlueSwitch_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("active")

#NEEDS ACTUAL LEVEL DESIGN TO BE USABLE

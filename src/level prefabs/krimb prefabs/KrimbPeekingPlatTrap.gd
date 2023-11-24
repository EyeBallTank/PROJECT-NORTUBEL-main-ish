extends Node2D

onready var switchsprite = $BlueSwitch/AnimatedSprite
onready var animation = $AnimationPlayer
onready var woodsprite = $KinematicBody2D/AnimatedSprite

func _ready():
	switchsprite.play("switchon")
	woodsprite.play("phase1")
	animation.play("RESET")

func _on_BlueSwitch_body_entered(body):
	if body.name == "StellaComp":
		animation.play("active")

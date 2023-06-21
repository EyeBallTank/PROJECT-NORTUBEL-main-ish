extends Node2D

onready var sprite = $KinematicBody2D/AnimatedSprite
onready var animation = $AnimationPlayer
onready var audio = $AudioStreamPlayer

func _ready():
	sprite.animation = "normal"
	animation.play("RESET")

func _on_Enter_body_entered(body):
	if body.name == "Player":
		sprite.animation = "open"

func _on_Drive_body_entered(body):
	if body.name == "Player":
		animation.play("Vanpath")
		audio.play()

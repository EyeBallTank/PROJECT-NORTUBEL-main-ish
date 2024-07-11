extends KinematicBody2D

onready var dialogue = $CanvasLayer
onready var animation = $AnimationPlayer

func _ready():
	dialogue.visible = false
	animation.play("RESET")



func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		animation.play("horatio shows up")

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		animation.play_backwards("horatio shows up")

extends KinematicBody2D

onready var dialogue = $CanvasLayer

#This is a basic implementation
#May need JSON files and Arrays in the future

func _ready():
	dialogue.visible = false
	pass


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true


func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false

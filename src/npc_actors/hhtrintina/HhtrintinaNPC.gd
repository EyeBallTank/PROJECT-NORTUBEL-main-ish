extends Node2D

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue

onready var nametext = $CanvasLayer/NinePatchRect2/Name


func _ready():
	dialogue.visible = false


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false

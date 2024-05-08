extends KinematicBody2D

#notes: move it to better location, add a coin and maybe make the windows transparent if the image files aren't ruined

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $Sprite
export(String) var customtext = "TARRAK_NPC_TALK"

onready var nametext = $CanvasLayer/NinePatchRect2/Name
export(String) var customname = "LARGE_TARRAK_NPC_NAME"

func _ready():
	maintext.text = str (customtext)
	nametext.text = str (customname)
	dialogue.visible = false
	sprite.play("MAINSTATE")


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true


func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false

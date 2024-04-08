extends KinematicBody2D

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $Sprite
export(String) var customtext = "XEMAROKK_NPC_TALK_LEGS"
export(String) var customtext2 = "XEMAROKK_NPC_TALK_HEAD"

onready var nametext = $CanvasLayer/NinePatchRect2/Name
export(String) var customname = "Xemarokk"

func _ready():
	maintext.text = str (customtext)
	nametext.text = str (customname)
	dialogue.visible = false
	sprite.play("MAINSTATE")


func _on_TalktoAreaLegs_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		maintext.text = str (customtext)


func _on_TalktoAreaLegs_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		maintext.text = str (customtext)


func _on_TalktoAreaHead_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		maintext.text = str (customtext2)


func _on_TalktoAreaHead_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		maintext.text = str (customtext2)

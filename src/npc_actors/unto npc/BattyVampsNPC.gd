extends KinematicBody2D

var honk = false

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue

var customtext = "BATTY_VAMPS_NPC_TALK_NO_VICTORY"

var customtext2 = "BATTY_VAMPS_NPC_TALK_YES_VICTORY"

func _ready():
	Signals.connect("the_bat_has_won", self, "_accept_the_bat_victory")
	maintext.text = str (customtext)
	dialogue.visible = false


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true


func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false

func _accept_the_bat_victory():
	maintext.text = str (customtext2)

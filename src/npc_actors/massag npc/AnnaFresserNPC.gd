extends KinematicBody2D


onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $Sprite
export(String) var customtext1 = "ANNAFRESSER_NPC_TALK_PRESWITCH"
export(String) var customtext2 = "ANNAFRESSER_NPC_TALK_POSTSWITCH"

onready var nametext = $CanvasLayer/NinePatchRect2/Name
export(String) var customname = "Anna Fresser"


func _ready():
	maintext.text = str (customtext1)
	nametext.text = str (customname)
	dialogue.visible = false
	sprite.play("swimming")
	Signals.connect("blue_switch_pressed", self, "anna_fresser_changes_line")

func anna_fresser_changes_line():
	maintext.text = str (customtext2)

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false

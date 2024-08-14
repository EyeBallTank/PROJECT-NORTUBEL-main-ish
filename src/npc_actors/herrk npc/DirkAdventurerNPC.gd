extends Node2D

onready var animation = $AnimationPlayer

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue

export(String) var customtext = "FAYGO_NPC_TALK_NOITEM"

func _ready():
	animation.play("RESET")
	maintext.text = str (customtext)
	dialogue.visible = false


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true


func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false


func _on_IsSeen_body_entered(body):
	animation.play("DirkRuns")


func _on_CaughtArea_body_entered(body):
	animation.play("DirkCaught2")

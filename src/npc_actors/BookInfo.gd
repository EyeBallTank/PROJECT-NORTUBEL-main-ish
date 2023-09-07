extends KinematicBody2D

onready var dialoguebox = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext = "BOOKHINT_1"
export var boardname = "board 1"
onready var sprite = $CanvasLayer/AnimatedSprite

#This is a basic implementation
#May need JSON files and Arrays in the future

func _ready():
	maintext.text = str (customtext)
	sprite.animation = boardname
#	customtext = maintext.text
	dialoguebox.visible = false
	pass


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialoguebox.visible = true


func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialoguebox.visible = false

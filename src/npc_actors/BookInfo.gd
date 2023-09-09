extends KinematicBody2D

onready var dialoguebox = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext = "BOOKHINT_1"
export var boardname = "board 1"
onready var sprite = $CanvasLayer/AnimatedSprite
onready var basicmessage = $Basicmessage

var test = false
#This is a basic implementation
#May need JSON files and Arrays in the future

func _ready():
	maintext.text = str (customtext)
	sprite.animation = boardname
#	customtext = maintext.text
	dialoguebox.visible = false
	basicmessage.visible = false

func _physics_process(delta):
	if test == true:
		if Input.is_action_just_pressed("standstill") and dialoguebox.visible == false:
			dialoguebox.visible = true
	elif test == false:
		dialoguebox.visible = false
	if Input.is_action_just_pressed("runaway"):
		test = false

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		basicmessage.visible = true
		test = true


func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		basicmessage.visible = false
		test = false

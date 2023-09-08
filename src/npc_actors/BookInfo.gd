extends KinematicBody2D

onready var dialoguebox = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext = "BOOKHINT_1"
export var boardname = "board 1"
onready var sprite = $CanvasLayer/AnimatedSprite

var test = false
#This is a basic implementation
#May need JSON files and Arrays in the future

func _ready():
	maintext.text = str (customtext)
	sprite.animation = boardname
#	customtext = maintext.text
	dialoguebox.visible = false

func _physics_process(delta):
	if test == true:
		if Input.is_action_just_pressed("kickball"):
			dialoguebox.visible = true
	elif test == false:
		dialoguebox.visible = false


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
			test = true


func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		test = false

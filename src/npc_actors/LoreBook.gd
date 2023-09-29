extends KinematicBody2D

onready var dialoguebox = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext = "BOOKHINT_1"
onready var basicmessage = $Basicmessage

var test = false

onready var sprite = $Sprite
export var spritename = "nortubel lorebook"

func _ready():
	sprite.animation = spritename
	maintext.text = str (customtext)
	dialoguebox.visible = false
	basicmessage.visible = false

func _physics_process(_delta):
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

extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO

onready var dialoguebox = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext1 = "BLABLA"
export(String) var customtext2 = "YESYES"
export(String) var customtext3 = "NONO"
export(String) var customtext4 = "OKOK"
export(String) var customname1 = "Carrie"
export(String) var customname2 = "Katrin"
onready var mainsprite = $AnimatedSprite
export var spritename = "carrie katrin"
onready var basicmessage = $basicmessage

var test = false

func _ready():
	mainsprite.animation = spritename
	maintext.text = str (customtext1)
	dialoguebox.visible = false
	basicmessage.visible = false

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if test == true:
		if Input.is_action_just_pressed("standstill") and dialoguebox.visible == false:
			dialoguebox.visible = true
	elif test == false:
		dialoguebox.visible = false
	if Input.is_action_just_pressed("runaway"):
		test = false

func _on_HearThemArea_body_entered(body):
	if body.name == "Player":
		basicmessage.visible = true
		test = true


func _on_HearThemArea_body_exited(body):
	if body.name == "Player":
		basicmessage.visible = false
		test = false

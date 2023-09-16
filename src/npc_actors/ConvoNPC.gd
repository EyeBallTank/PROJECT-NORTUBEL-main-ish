extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO

onready var animationplayer = $AnimationPlayer
onready var dialoguebox = $CanvasLayer
onready var maintext1 = $CanvasLayer/NinePatchRect/Dialogue1
onready var maintext2 = $CanvasLayer/NinePatchRect/Dialogue2
onready var maintext3 = $CanvasLayer/NinePatchRect/Dialogue3
onready var maintext4 = $CanvasLayer/NinePatchRect/Dialogue4
onready var char1 = $CanvasLayer/NinePatchRect2/Name1
onready var char2 = $CanvasLayer/NinePatchRect2/Name2
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
	maintext1.text = str (customtext1)
	maintext2.text = str (customtext2)
	maintext3.text = str (customtext3)
	maintext4.text = str (customtext4)
	char1.text = str (customname1)
	char2.text = str (customname2)
	dialoguebox.visible = false
	basicmessage.visible = false

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if test == true:
		if Input.is_action_just_pressed("standstill") and dialoguebox.visible == false:
			dialoguebox.visible = true
			animationplayer.play("maintalk")
	elif test == false:
		dialoguebox.visible = false
		animationplayer.stop()
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

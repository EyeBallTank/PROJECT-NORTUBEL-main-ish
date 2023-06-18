extends KinematicBody2D
#Similar script to Carrie
#NOTE: Oscar and Pete use the "older version" of the sprite sheet
#instead of the "still wip" version
#When i redo sprites, i NEED to remember this very well
export var gravity: = 2960
var velocity = Vector2.ZERO
var honk = false

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext = "OSCAR_TALK_1"
export(String) var customtext3 = "OSCAR_HUG"
export(String) var customtext4 = "OSCAR_HURT"

func _ready():
	maintext.text = str (customtext)
	dialogue.visible = false

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if honk == true:
		if Input.is_action_just_pressed("followme"):
			maintext.text = str (customtext3)
		if Input.is_action_just_pressed("attack"):
			maintext.text = str (customtext4)

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honk = false
		maintext.text = str (customtext)

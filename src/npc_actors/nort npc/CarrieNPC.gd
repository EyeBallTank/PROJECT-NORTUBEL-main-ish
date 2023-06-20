extends KinematicBody2D
#When not playable, protagonists can be NPC's
#CARRIE AND KATRIN USE THE "still wip" SPRITE SHEET VERSION
#MELVIN USES THE "older version" version, which in Krita had 155 pixels and subdivision of 3 i think
export var gravity: = 2960
var velocity = Vector2.ZERO
var honk = false

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext = "CARRIE_TALK_1"
export(String) var customtext2 = "CARRIE_HONK"
export(String) var customtext3 = "CARRIE_HUG"
export(String) var customtext4 = "CARRIE_HURT"

func _ready():
	maintext.text = str (customtext)
	dialogue.visible = false

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if honk == true:
		if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("standstill"):
			maintext.text = str (customtext2)
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

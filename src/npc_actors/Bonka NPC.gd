extends KinematicBody2D

#NOT YET
#MAY GIVE HER ACTUAL SPRITES AND STUFF SOON

export var gravity: = 2960
var velocity = Vector2.ZERO

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
export(String) var customtext = "BONKA_TALK_1"

func _ready():
	maintext.text = str (customtext)
	dialogue.visible = false
	pass

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false

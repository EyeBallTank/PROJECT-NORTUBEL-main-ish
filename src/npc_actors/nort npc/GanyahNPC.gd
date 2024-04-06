extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $Sprite
export(String) var customtext = "GANYAH_NPC_TALK"

onready var nametext = $CanvasLayer/NinePatchRect2/Name
export(String) var customname = "Ganyah"

func _ready():
	maintext.text = str (customtext)
	nametext.text = str (customname)
	dialogue.visible = false
	sprite.play("MAINSTATE")

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)


 

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false

extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $Sprite
export(String) var customtext = "Beeeeehh"

onready var mainsprite = $Sprite
export var spritename = "MAINSTATE"
export var secondspritename = "Otherstate"

onready var nametext = $CanvasLayer/NinePatchRect2/Name
export(String) var customname = "Electric Sheep"

func _ready():
	maintext.text = str (customtext)
	nametext.text = str (customname)
	dialogue.visible = false
	mainsprite.animation = spritename

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		mainsprite.animation = secondspritename
		
func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		mainsprite.animation = spritename

extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $Sprite
export(String) var customtext = "..."
export(String) var customtext2 = "BARNEY_HUG"
export(String) var customtext3 = "BARNEY_HURT"
var honk = false


onready var mainsprite = $Sprite
export var spritename = "MAINSTATE"
export var secondspritename = "Otherstate"

onready var nametext = $CanvasLayer/NinePatchRect2/Name
export(String) var customname = "Barney Mackenstein"

func _ready():
	maintext.text = str (customtext)
	nametext.text = str (customname)
	dialogue.visible = false
	mainsprite.animation = spritename

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	if honk == true:
		if Input.is_action_just_pressed("followme"):
			maintext.text = str (customtext2)
		if Input.is_action_just_pressed("attack"):
			maintext.text = str (customtext3)
			sprite.play("Falling")


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		mainsprite.animation = secondspritename
		honk = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		mainsprite.animation = spritename
		honk = false
		maintext.text = str (customtext)



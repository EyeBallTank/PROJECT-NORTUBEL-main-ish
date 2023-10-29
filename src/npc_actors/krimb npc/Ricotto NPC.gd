extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO
var honk = false

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $AnimatedSprite

export(String) var customtext = "RICOTTO_TALK_NOITEM"
export(String) var customtext2 = "RICOTTO_TALK_YESITEM"
export(String) var customtext3 = "RICOTTO_HUG"
export(String) var customtext4 = "RICOTTO_HURT"

func _ready():
	maintext.text = str (customtext)
	dialogue.visible = false
	sprite.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if honk == true:
		if Input.is_action_just_pressed("followme"):
			maintext.text = str (customtext3)
			sprite.play("Idle")
		if Input.is_action_just_pressed("attack"):
			maintext.text = str (customtext4)
			sprite.play("Hurt")


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true
		if body.hastradeitem == true:
			maintext.text = str (customtext2)
			sprite.play("HasItem")
		else:
			pass

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		if body.hastradeitem == false:
			honk = false
			maintext.text = str (customtext)
			sprite.play("Idle")
		else:
			pass

extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO
var honk = false
onready var audioplayer = $AudioStreamPlayer
onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $AnimatedSprite

export(String) var customtext = "LEON_TALK"
export(String) var customtext2 = "LEON_HUG"
export(String) var customtext3 = "LEON_HURT"

func _ready():
	maintext.text = str (customtext)
	dialogue.visible = false
	sprite.play("default")

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if honk == true:
		if Input.is_action_just_pressed("followme"):
			maintext.text = str (customtext2)
			sprite.play("hugged")
			audioplayer.play()
			yield(audioplayer, "finished")
		if Input.is_action_just_pressed("attack"):
			maintext.text = str (customtext3)
			sprite.play("knife")


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true
		sprite.play("looking")

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honk = false
		maintext.text = str (customtext)
		sprite.play("default")

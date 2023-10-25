extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO
var fightback : int = 0
var honk = false
#Note: The "honk" feature only works with characters that are canonically 18 or older.
onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $AnimatedSprite
onready var animationplayer = $AnimationPlayer
export(String) var customtext = "SARAHNPC_TALK"
export(String) var customtext2 = "SARAHNPC_HONK"
export(String) var customtext3 = "SARAHNPC_HUG"
export(String) var customtext4 = "SARAHNPC_HURT"

func _ready():
	animationplayer.play("RESET")
	maintext.text = str (customtext)
	dialogue.visible = false
	sprite.play("Idle")

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
			sprite.play("Knife")
			fightback += 1
	
	if fightback == 2 and Input.is_action_just_pressed("attack"):
		fightback = 2
		animationplayer.play("Fightingback")


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honk = false
		fightback = 0
		maintext.text = str (customtext)
		sprite.play("Idle")

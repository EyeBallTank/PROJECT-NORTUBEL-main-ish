extends KinematicBody2D
#NOT YET
#MAY GIVE HER ACTUAL SPRITES AND STUFF SOON
export var gravity: = 2960
var velocity = Vector2.ZERO
var honk = false
#Note: The "honk" feature only works with characters that are canonically 18 or older.
onready var audioplayer = $AudioStreamPlayer
onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var sprite = $Sprite
export(String) var customtext = "BONKA_TALK_1"
export(String) var customtext2 = "BONKA_HONK"
export(String) var customtext3 = "BONKA_HUG"
export(String) var customtext4 = "BONKA_HURT"

func _ready():
	maintext.text = str (customtext)
	dialogue.visible = false
	sprite.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if honk == true:
		if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("standstill"):
			maintext.text = str (customtext2)
			sprite.play("Honked")
			audioplayer.play()
			yield(audioplayer, "finished")
		if Input.is_action_just_pressed("followme"):
			maintext.text = str (customtext3)
			sprite.play("Hugged")
		if Input.is_action_just_pressed("attack"):
			maintext.text = str (customtext4)
			sprite.play("Knife")

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honk = false
		maintext.text = str (customtext)
		sprite.play("Idle")

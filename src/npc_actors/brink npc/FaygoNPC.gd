extends KinematicBody2D

export var gravity: = 2960
var velocity = Vector2.ZERO
var honk = false

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue

export(String) var customtext = "FAYGO_NPC_TALK_NOITEM"
export(String) var customtext2 = "FAYGO_NPC_TALK_YESITEM"
export(String) var customtext3 = "FAYGO_NPC_HUG"
export(String) var customtext4 = "FAYGO_NPC_HURT"
export(String) var customtext5 = "FAYGO_NPC_HONK"

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
		if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("standstill"):
			maintext.text = str (customtext5)


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true
		if body.hastradeitem == true:
			maintext.text = str (customtext2)
			Signals.emit_signal("trade_item_received")
		else:
			pass

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		if body.hastradeitem == false:
			honk = false
			maintext.text = str (customtext)
		else:
			honk = false

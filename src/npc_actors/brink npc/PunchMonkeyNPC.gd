extends KinematicBody2D


var honk = false

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var animationplayer = $AnimationPlayer

export(String) var customtext = "PUNCH_MONKEY_NPC_TALK_NOITEM"
export(String) var customtext2 = "PUNCH_MONKEY_NPC_TALK_YESITEM"
export(String) var customtext3 = "PUNCH_MONKEY_NPC_HUG"
export(String) var customtext4 = "PUNCH_MONKEY_NPC_HURT"

func _ready():
	animationplayer.play("RESET")
	maintext.text = str (customtext)
	dialogue.visible = false

func _physics_process(delta):
	if honk == true:
		if Input.is_action_just_pressed("followme"):
			maintext.text = str (customtext3)
		if Input.is_action_just_pressed("attack"):
			maintext.text = str (customtext4)


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

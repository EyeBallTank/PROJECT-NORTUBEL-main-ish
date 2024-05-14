extends KinematicBody2D


var honk = false
var nobanana = true
var bananatime = 0

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
#	if nobanana == false:
#		if bananatime == 0:
#			animationplayer.play("gotbananas")
#			yield(animationplayer, "animation_finished")
#			nobanana = true
#			bananatime + 1
#			animationplayer.play("RESET2")
#		elif bananatime == 1:
#			animationplayer.play("RESET2")

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true
		if body.hastradeitem == true:
			maintext.text = str (customtext2)
			Signals.emit_signal("trade_item_received")
#			nobanana = false
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

func _on_AnimationArea_body_entered(body):
	if body.name == "Player":
		if body.hastradeitem == true:
			animationplayer.play("gotbananas")
		else:
			pass

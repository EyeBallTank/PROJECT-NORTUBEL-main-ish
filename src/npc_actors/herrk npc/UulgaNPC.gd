extends Node2D

var honk = false
var honktwo = false
var nobanana = true

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialogue
onready var animationplayer = $AnimationPlayer

export(String) var customtext = "UULGA_NPC_TALK_NO_ITEM"
export(String) var customtext2 = "UULGA_NPC_TALK_YES_ITEM"
export(String) var customtext3 = "UULGA_NPC_HUG"
export(String) var customtext4 = "UULGA_NPC_HURT"
export(String) var customtext5 = "UULGA_NPC_HONK"


func _ready():
	animationplayer.play("RESET")
	maintext.text = str (customtext)
	dialogue.visible = false

func _physics_process(delta):
	if honktwo == true:
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


func _on_AnotherTalkArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honktwo = true



func _on_AnotherTalkArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honktwo = false
		maintext.text = str (customtext2)

extends Node2D

var honktwo = false

onready var dialogue = $CanvasLayer
onready var maintext = $CanvasLayer/NinePatchRect/Dialouge
onready var animationplayer = $AnimationPlayer

export(String) var customtext = "BEATRICE_NPC_TALK"
export(String) var customtext2 = "BEATRICE_NPC_HUG"
export(String) var customtext3 = "BEATRICE_NPC_HURT"
export(String) var customtext4 = "BEATRICE_NPC_HONK"

func _ready():
	animationplayer.play("RESET")
	maintext.text = str (customtext)
	dialogue.visible = false

func _physics_process(delta):
	if honktwo == true:
		if Input.is_action_just_pressed("followme"):
			maintext.text = str (customtext2)
		if Input.is_action_just_pressed("attack"):
			maintext.text = str (customtext3)
		if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("standstill"):
			maintext.text = str (customtext4)


func _on_TalkToArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honktwo = true


func _on_TalkToArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honktwo = false
		maintext.text = str (customtext)




func _on_FreeMe_area_entered(area):
	if area.name == "PlayerMelee":
		animationplayer.play("free")

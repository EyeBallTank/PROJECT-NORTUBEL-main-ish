extends KinematicBody2D

onready var dialoguebox = $CanvasLayer

#Again: the characters that the Q + S input applies to are 18 or older
#And even then, the potential fan service on this game won't be that extreme.

func _ready():
	dialoguebox.visible = false


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialoguebox.visible = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialoguebox.visible = false

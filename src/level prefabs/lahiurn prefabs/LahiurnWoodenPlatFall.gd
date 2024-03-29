extends Node2D

onready var mainplatform = $KinematicBody2D
onready var ropeleft = $RopeLeft
onready var roperight = $RopeRight
onready var animation = $AnimationPlayer

#UNRELATED TO THIS SCENE BUT SETTING THE BUCKET TO "CHARACTER" SEEMS TO WORK

enum {
	NORMAL,
	LEFTATTACH,
	RIGHTATTACH,
	FALLFROMLEFT,
	FALLFROMRIGHT
}

var state = NORMAL

func _ready():
	animation.play("RESET")

func _physics_process(delta):

	match state:
		NORMAL:
			pass
		LEFTATTACH:
			pass
		RIGHTATTACH:
			pass
		FALLFROMLEFT:
			pass
		FALLFROMRIGHT:
			pass


func _on_RopeLeft_area_entered(area):
	if area.name == "PlayerMelee":
		if state == NORMAL:
			animation.play("TheLeftWasCut")
			state = RIGHTATTACH
		elif state == LEFTATTACH:
			animation.play("AndSoWasLeft")
			state = FALLFROMLEFT

func _on_RopeRight_area_entered(area):
	if area.name == "PlayerMelee":
		if state == NORMAL:
			animation.play("TheRightWasCut")
			state = LEFTATTACH
		elif state == RIGHTATTACH:
			animation.play("AndSoWasRight")
			state = FALLFROMRIGHT

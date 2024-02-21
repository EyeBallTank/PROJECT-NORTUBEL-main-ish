extends Node2D

onready var mainplatform = $KinematicBody2D
onready var ropeleft = $RopeLeft
onready var roperight = $RopeRight
onready var animation = $AnimationPlayer


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



func _on_RopeLeft_area_entered(area):
	if area.name == "PlayerMelee":
		pass

func _on_RopeRight_area_entered(area):
	if area.name == "PlayerMelee":
		pass

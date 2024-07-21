extends Node2D

onready var animation = $AnimationPlayer


func _ready():
	animation.play("RESET")
	Signals.connect("blue_switch_pressed", self, "_sub_alarm_is_on")

func _sub_alarm_is_on():
	animation.play("alarmon")

#IDEA: IF BLUE SWITCH PRESSED, WATER RISES UP (LIKE IN MASSAGLEVEL2) AND A HORIZONTAL DOOR
#OPENS TO REVEAL AN UPPER ROOM NOT AFFECTED BY WATER

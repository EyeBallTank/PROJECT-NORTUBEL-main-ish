extends Node2D

onready var animation = $AnimationPlayer
onready var otheranimation = $AnimationPlayer2
onready var musicplayer = $MusicPlayer

func _ready():
	animation.play("RESET")
	otheranimation.play("WaterDown")
	Signals.connect("blue_switch_pressed", self, "_sub_alarm_is_on")

func _sub_alarm_is_on():
	animation.play("alarmon")
	otheranimation.play("WaterUp")
	musicplayer.play("WaterMusic")

#IDEA: IF BLUE SWITCH PRESSED, WATER RISES UP (LIKE IN MASSAGLEVEL2) AND A HORIZONTAL DOOR
#OPENS TO REVEAL AN UPPER ROOM NOT AFFECTED BY WATER

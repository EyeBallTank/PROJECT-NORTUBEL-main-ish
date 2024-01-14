extends Node2D

onready var animation = $AnimationPlayer


func _ready():
	animation.play("RESET")
	Signals.connect("blue_switch_pressed", self, "_sub_alarm_is_on")

func _sub_alarm_is_on():
	animation.play("alarmon")

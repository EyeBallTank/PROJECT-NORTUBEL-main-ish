extends Node2D

onready var animation = $AnimationPlayer

func _ready():
	Signals.connect("green_switch_one_pressed", self, "_on_GreenSwitchOne_pressed")
	Signals.connect("green_switch_two_pressed", self, "_on_GreenSwitchTwo_pressed")

func _on_GreenSwitchOne_pressed():
	animation.play("skychange")

func _on_GreenSwitchTwo_pressed():
	animation.play_backwards("skychange")

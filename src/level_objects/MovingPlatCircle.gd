extends Node2D

onready var animationplayer = $AnimationPlayer

func _ready():
	Signals.connect("green_switch_one_pressed", self, "_on_GreenSwitchOne_pressed")
	Signals.connect("green_switch_two_pressed", self, "_on_GreenSwitchTwo_pressed")

func _on_GreenSwitchOne_pressed():
	Signals.emit_signal("halfcircle_plat_active_one")
	animationplayer.play("HalfCirclePath")

func _on_GreenSwitchTwo_pressed():
	Signals.emit_signal("halfcircle_plat_active_two")
	animationplayer.play_backwards("HalfCirclePath")

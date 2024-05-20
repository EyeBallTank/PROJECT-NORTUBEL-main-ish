extends Node2D

#SEPERATE MAIN CHARACTERS TO MAKE THIS WORK, LIKE THE FLYING THING IN K4TR1N
#
#MOVES FAST IN AN "INVISIBLE" BRIDGE MADE OF THIN LINES
#IF PLAYER FALLS THEY GET A SOMEWHAT LONGER PATH WITH SOME HAZARDS OR SOMETHING
#MAYBE NEED 2 GREENSWITCH ONE VARIATIONS?


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

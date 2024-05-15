extends Node2D

onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")
	Signals.connect("yellow_switch_pressed", self, "_on_YellowSwitch_pressed")

func _on_YellowSwitch_pressed():
	print("YELPLAT IS ACTIVE")
#	Signals.emit_signal("yellow_plat_verti_active")
	animationplayer.play("growing")
	yield(get_tree().create_timer(9), "timeout")
	animationplayer.play_backwards("growing")

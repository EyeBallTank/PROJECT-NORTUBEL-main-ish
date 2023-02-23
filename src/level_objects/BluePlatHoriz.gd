extends Node2D

onready var animationplayer = $AnimationPlayer

enum {
	FROZENPLAT,
	ACTIVEPLAT
}

var state = FROZENPLAT

func _ready():
	animationplayer.play("IdlePlat")
	Signals.connect("blue_switch_pressed", self, "_on_BlueSwitch_pressed")

func _process(delta):
	match state:
		FROZENPLAT:
			pass
		ACTIVEPLAT:
			animationplayer.play("HorizontalPlat")

func _on_BlueSwitch_pressed():
	print("IS ACTIVE")
#	Signals.emit_signal("blue_plat_horiz_active", blueactivation)
	state = ACTIVEPLAT
	

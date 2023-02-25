extends Node2D

#Might have to change the animation to make it work with yellow switch

onready var animationplayer = $AnimationPlayer

#enum {
#	FROZENPLAT,
#	ACTIVEPLAT
#}

#var state = FROZENPLAT

func _ready():
	Signals.connect("yellow_switch_pressed", self, "_on_YellowSwitch_pressed")
#
#func _process(delta):
#	match state:
#		FROZENPLAT:
#			pass
#		ACTIVEPLAT:
#			animationplayer.play("HorizontalPlat")
#
func _on_YellowSwitch_pressed():
	print("YELPLAT IS ACTIVE")
	Signals.emit_signal("yellow_plat_verti_active")
	animationplayer.play("VerticalPlat")
	yield(get_tree().create_timer(3), "timeout")
	animationplayer.play_backwards("VerticalPlat")
#	state = ACTIVEPLAT
#

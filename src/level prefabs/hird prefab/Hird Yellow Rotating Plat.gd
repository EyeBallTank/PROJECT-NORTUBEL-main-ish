extends Node2D

onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")
	Signals.connect("yellow_switch_pressed", self, "_yel_rotate_plat")

func _yel_rotate_plat():
	animationplayer.play("Horiz")
	yield(get_tree().create_timer(3), "timeout")
	animationplayer.play_backwards("Horiz")

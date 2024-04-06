extends Node2D

onready var animationplayer = $AnimationPlayer


func _ready():
	animationplayer.play("RESET")
	Signals.connect("blue_switch_pressed", self, "_atlantis_water_level_down")

func _atlantis_water_level_down():
	animationplayer.play("valve_active")

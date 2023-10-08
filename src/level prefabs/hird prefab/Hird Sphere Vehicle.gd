extends Node2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")
	Signals.connect("blue_switch_pressed", self, "_sphere_active")

func _sphere_active():
	animation.play("ride")

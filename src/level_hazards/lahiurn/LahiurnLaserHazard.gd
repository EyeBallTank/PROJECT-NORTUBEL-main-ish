extends Node2D

onready var animation = $AnimationPlayer


func _ready():
	animation.play("RESET")
	Signals.connect("katrin_was_seen", self, "_lahiurn_laser_active")

func _lahiurn_laser_active():
	animation.play("activelaser")

extends Node2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("starattack")
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func die():
	queue_free()

func therefore_I_Go():
	die()

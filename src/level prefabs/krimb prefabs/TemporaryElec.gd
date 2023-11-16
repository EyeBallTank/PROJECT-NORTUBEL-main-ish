extends KinematicBody2D

onready var animationplayer = $AnimationPlayer


func _ready():
	elec_disappear()
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func elec_disappear():
	animationplayer.play("elecvanish")

func disappear():
	queue_free()

func therefore_I_Go():
	disappear()

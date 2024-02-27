extends KinematicBody2D

onready var positiontest = $Position2D
onready var animationplayer = $AnimationPlayer
const Electricity = preload("res://src/level prefabs/grek prefabs/GrekMultigunElec.tscn")

func _ready():
	ball_disappear()
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func ball_disappear():
	animationplayer.play("ballvanish")

func disappear():
	queue_free()

func therefore_I_Go():
	disappear()

func attack():
	var projectile = Electricity.instance()
	projectile.global_position = positiontest.global_position
	get_tree().get_root().add_child(projectile)

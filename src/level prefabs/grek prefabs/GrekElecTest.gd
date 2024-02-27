extends KinematicBody2D

onready var positiontest = $Position2D
onready var animationplayer = $AnimationPlayer
const Electricity = preload("res://src/level prefabs/grek prefabs/GrekMultigunElec.tscn")
#grek_gun_active
func _ready():
#	ball_disappear()
	Signals.connect("scene_has_changed", self, "therefore_I_Go")
	Signals.connect("grek_gun_active", self, "_the_grek_gun_is_active")

func ball_disappear():
	animationplayer.play("ballvanish")

func disappear():
	queue_free()

func therefore_I_Go():
	disappear()

func _the_grek_gun_is_active():
	ball_disappear()

func attack():
	var projectile = Electricity.instance()
	projectile.global_position = positiontest.global_position
	get_tree().get_root().add_child(projectile)

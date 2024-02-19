extends RigidBody2D

onready var animationplayer = $AnimationPlayer
onready var elecplace = $Position2D
onready var sound = $AudioStreamPlayer2D
const Electricity = preload("res://src/enemies/greklovick/TemporaryExplosion.tscn")

func _ready():
	ball_disappear()
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func ball_disappear():
	animationplayer.play("BallVanish")


func disappear():
	queue_free()

func therefore_I_Go():
	disappear()

func attack():
	sound.play()
	var projectile = Electricity.instance()
	projectile.global_position = elecplace.global_position
	get_tree().get_root().add_child(projectile)

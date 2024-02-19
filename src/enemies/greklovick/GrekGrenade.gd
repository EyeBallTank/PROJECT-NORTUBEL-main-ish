extends RigidBody2D

onready var animationplayer = $AnimationPlayer

func _ready():
	ball_disappear()
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func ball_disappear():
	animationplayer.play("BallVanish")


func disappear():
	queue_free()

func therefore_I_Go():
	disappear()

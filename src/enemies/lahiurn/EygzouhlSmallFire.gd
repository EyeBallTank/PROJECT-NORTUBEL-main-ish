extends KinematicBody2D

onready var animationplayer = $AnimationPlayer
onready var timer = $Timer

func _ready():
	timer.start(2)
	elec_disappear()
	Signals.connect("scene_has_changed", self, "therefore_I_Go")
	Signals.connect("you_are_invincible", self, "_i_am_invincible")

func _physics_process(delta):
	pass

#func _i_am_invincible():
#	animation.play("RESET")
#
#func not_anymore():
#	animation.play("poison")

func elec_disappear():
	animationplayer.play("elecvanish")

func disappear():
	queue_free()

func therefore_I_Go():
	disappear()

func _on_poisonlikedamage_body_entered(body):
	if body.is_in_group("protagonists"):
		body.health -= 1

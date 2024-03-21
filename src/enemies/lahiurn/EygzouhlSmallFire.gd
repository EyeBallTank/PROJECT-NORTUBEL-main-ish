extends KinematicBody2D

onready var animationplayer = $AnimationPlayer
onready var timer = $Timer

func _ready():
	animationplayer.play("elecvanish")
	timer.start(2)
	Signals.connect("scene_has_changed", self, "therefore_I_Go")
	Signals.connect("you_are_invincible", self, "_i_am_invincible")

func _physics_process(delta):
	if timer.time_left == 0:
		disappear()

func _i_am_invincible():
	animationplayer.play("RESET")
#
func not_anymore():
	animationplayer.play("elecvanish")

#func elec_disappear():
#	animationplayer.play("elecvanish")

func disappear():
	queue_free()

func therefore_I_Go():
	disappear()

func _on_poisonlikedamage_body_entered(body):
	if body.is_in_group("protagonists"):
		body.health -= 1
